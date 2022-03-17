--------------------------
-- INIZIO NUOVE REGOLE 770 per punto SX01 - 001
---------------------------
declare
  i integer;
begin
  select COUNT(*) into i from P602_770REGOLE t where t.Anno=2012;
  if i > 0 then
     DELETE P602_770REGOLE t WHERE t.Anno=2012 and t.Parte = 'SX01' AND t.NUMERO IN('001');

insert into P602_770REGOLE (anno, parte, numero, tipo_record, sezione_file, formato_file, parte_cud, numero_cud, descrizione, numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, formato_annomese, numero_file, cod_arrotondamento_file)
values (2012, 'SX01', '001', 'F', 'SX', 'VP', null, null, 'Credito derivante da conguaglio di fine anno o per cessazione del rapporto di lavoro in corso d''anno', 'S', null, 'M=S,D=2,0=N', 'S', 'SELECT -SUM(IMPORTO) DATO FROM' || chr(10) || '(' || chr(10) || '-- Query per raggruppare per data cedolino' || chr(10) || 'SELECT DATA_CEDOLINO, SUM(IMPORTO) IMPORTO FROM' || chr(10) || '(' || chr(10) || '-- Query di dettaglio' || chr(10) || '-- Conguaglio IRPEF effettuato nei mesi di Gennaio e Febbraio dell''anno successivo' || chr(10) || 'SELECT P441.PROGRESSIVO, P441.DATA_CEDOLINO, P442.IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND TO_CHAR(P441.DATA_CEDOLINO,''YYYYMM'') BETWEEN TRIM(TO_CHAR(TO_NUMBER(:Anno + 1)))||''01'' AND TRIM(TO_CHAR(TO_NUMBER(:Anno + 1)))||''02''' || chr(10) || 'AND P441.CHIUSO = ''S'' AND P441.TIPO_CEDOLINO <> ''RP''' || chr(10) || 'AND P442.COD_VOCE||P442.COD_VOCE_SPECIALE IN (''11210CONG'')' || chr(10) || 'AND TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') > TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'')' || chr(10) || 'AND P442.TIPO_RECORD = ''M''' || chr(10) || ')' || chr(10) || 'GROUP BY DATA_CEDOLINO' || chr(10) || ')' || chr(10) || 'WHERE IMPORTO < 0' || chr(10) || '', 'SELECT -SUM(IMPORTO) DATO FROM' || chr(10) || '(' || chr(10) || '-- Query per raggruppare per data cedolino' || chr(10) || 'SELECT DATA_CEDOLINO, SUM(IMPORTO) IMPORTO FROM' || chr(10) || '(' || chr(10) || '-- Query di dettaglio' || chr(10) || '-- Conguaglio IRPEF effettuato nei mesi di Gennaio e Febbraio dell''anno successivo' || chr(10) || 'SELECT P441.PROGRESSIVO, P441.DATA_CEDOLINO, P442.IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND TO_CHAR(P441.DATA_CEDOLINO,''YYYYMM'') BETWEEN TRIM(TO_CHAR(TO_NUMBER(:Anno + 1)))||''01'' AND TRIM(TO_CHAR(TO_NUMBER(:Anno + 1)))||''02''' || chr(10) || 'AND P441.CHIUSO = ''S'' AND P441.TIPO_CEDOLINO <> ''RP''' || chr(10) || 'AND P442.COD_VOCE||P442.COD_VOCE_SPECIALE IN (''11210CONG'')' || chr(10) || 'AND TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') > TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'')' || chr(10) || 'AND P442.TIPO_RECORD = ''M''' || chr(10) || ')' || chr(10) || 'GROUP BY DATA_CEDOLINO' || chr(10) || ')' || chr(10) || 'WHERE IMPORTO < 0' || chr(10) || '', 'N', null, 'N', '001', 'P1');

  end if;
end;
/

---------------------------
-- FINE NUOVE REGOLE 770 per punto SX01 - 001
---------------------------

--
-- Inizio creazione posizioni economiche MV012 e MV007
--

declare 
  i integer;
  ID_P221 integer;
  CodPosEconom varchar2(5);
  
  CURSOR C1 IS  
  select * from P220_LIVELLI t 
  where t.cod_contratto='EDP' and t.cod_posizione_economica='MV027'
  order by t.decorrenza;

begin
CodPosEconom:='MV012';
  
select COUNT(*) into i from P220_LIVELLI t 
where t.cod_contratto='EDP' and t.cod_posizione_economica=CodPosEconom;

if i = 0 then

  -- Creazione posizione economica MV012
  FOR T1 IN C1 LOOP
    SELECT P221_ID_LIVELLO.NEXTVAL INTO ID_P221 FROM DUAL;
   
    insert into p220_livelli
      (cod_contratto, cod_posizione_economica, decorrenza, id_livello, categoria_economica, cod_livello, descrizione, decorrenza_fine, cod_posizione_economica_succ)
    values
      (T1.cod_contratto, CodPosEconom, T1.decorrenza, ID_P221, T1.categoria_economica, T1.cod_livello, 'Dirigente area chirurgica II livello (tempo definito)', T1.decorrenza_fine, T1.cod_posizione_economica_succ);
  
    insert into P221_LIVELLIIMPORTI
    select ID_P221, cod_voce, cod_voce_speciale, importo, erogazione_mesi from p221_livelliimporti t
      where t.id_livello=t1.id_livello;

    update P221_LIVELLIIMPORTI t set t.importo=172.15
      where t.cod_voce='00205' and t.cod_voce_speciale='BASE' and t.id_livello in
        (select v.id_livello from p220_livelli v where v.cod_contratto='EDP' and v.cod_posizione_economica=CodPosEconom);
    
    update P221_LIVELLIIMPORTI t set t.importo=258.62
      where t.cod_voce='00210' and t.cod_voce_speciale='BASE' and t.id_livello in
        (select v.id_livello from p220_livelli v where v.cod_contratto='EDP' and v.cod_posizione_economica=CodPosEconom
           and v.decorrenza=to_date('01072001','ddmmyyyy'));
    
    update P221_LIVELLIIMPORTI t set t.importo=291.95
      where t.cod_voce='00210' and t.cod_voce_speciale='BASE' and t.id_livello in
        (select v.id_livello from p220_livelli v where v.cod_contratto='EDP' and v.cod_posizione_economica=CodPosEconom
           and v.decorrenza=to_date('01012002','ddmmyyyy'));
    
    update P221_LIVELLIIMPORTI t set t.importo=333.62
      where t.cod_voce='00210' and t.cod_voce_speciale='BASE' and t.id_livello in
        (select v.id_livello from p220_livelli v where v.cod_contratto='EDP' and v.cod_posizione_economica=CodPosEconom
           and v.decorrenza>to_date('01012002','ddmmyyyy'));
    
    update P221_LIVELLIIMPORTI t set t.importo=267.18
      where t.cod_voce='00215' and t.cod_voce_speciale='BASE' and t.id_livello in
        (select v.id_livello from p220_livelli v where v.cod_contratto='EDP' and v.cod_posizione_economica=CodPosEconom);
    
  END LOOP; 

end if;

CodPosEconom:='MV007';
  
select COUNT(*) into i from P220_LIVELLI t 
where t.cod_contratto='EDP' and t.cod_posizione_economica=CodPosEconom;

if i = 0 then

  -- Creazione posizione economica MV007
  FOR T1 IN C1 LOOP
    SELECT P221_ID_LIVELLO.NEXTVAL INTO ID_P221 FROM DUAL;
   
    insert into p220_livelli
      (cod_contratto, cod_posizione_economica, decorrenza, id_livello, categoria_economica, cod_livello, descrizione, decorrenza_fine, cod_posizione_economica_succ)
    values
      (T1.cod_contratto, CodPosEconom, T1.decorrenza, ID_P221, T1.categoria_economica, T1.cod_livello, 'Dirigente area medica II livello (tempo definito)', T1.decorrenza_fine, T1.cod_posizione_economica_succ);
  
    insert into P221_LIVELLIIMPORTI
    select ID_P221, cod_voce, cod_voce_speciale, importo, erogazione_mesi from p221_livelliimporti t
      where t.id_livello=t1.id_livello;

    update P221_LIVELLIIMPORTI t set t.importo=172.15
      where t.cod_voce='00205' and t.cod_voce_speciale='BASE' and t.id_livello in
        (select v.id_livello from p220_livelli v where v.cod_contratto='EDP' and v.cod_posizione_economica=CodPosEconom);
    
    update P221_LIVELLIIMPORTI t set t.importo=187.82
      where t.cod_voce='00210' and t.cod_voce_speciale='BASE' and t.id_livello in
        (select v.id_livello from p220_livelli v where v.cod_contratto='EDP' and v.cod_posizione_economica=CodPosEconom
           and v.decorrenza=to_date('01072001','ddmmyyyy'));
    
    update P221_LIVELLIIMPORTI t set t.importo=221.15
      where t.cod_voce='00210' and t.cod_voce_speciale='BASE' and t.id_livello in
        (select v.id_livello from p220_livelli v where v.cod_contratto='EDP' and v.cod_posizione_economica=CodPosEconom
           and v.decorrenza=to_date('01012002','ddmmyyyy'));
    
    update P221_LIVELLIIMPORTI t set t.importo=262.82
      where t.cod_voce='00210' and t.cod_voce_speciale='BASE' and t.id_livello in
        (select v.id_livello from p220_livelli v where v.cod_contratto='EDP' and v.cod_posizione_economica=CodPosEconom
           and v.decorrenza>to_date('01012002','ddmmyyyy'));
    
    update P221_LIVELLIIMPORTI t set t.importo=261.5
      where t.cod_voce='00215' and t.cod_voce_speciale='BASE' and t.id_livello in
        (select v.id_livello from p220_livelli v where v.cod_contratto='EDP' and v.cod_posizione_economica=CodPosEconom);
    
  END LOOP; 

end if;
end;

/

--
-- Fine creazione posizioni economiche MV012 e MV007
--

insert into p004_codicitabannuali
select cod_tabannuale, '47', anno, 'Cessazione per esodo legge n. 92/2012 - solo D.M.A. 2' from p004_codicitabannuali t
where t.cod_tabannuale='IPCAUSCESS' and t.cod_codicitabannuali='46'
and not exists
(select 'x' from p004_codicitabannuali v where v.cod_tabannuale=t.cod_tabannuale and v.anno=t.anno
and v.cod_codicitabannuali='47');

INSERT INTO P004_CODICITABANNUALI
SELECT COD_TABANNUALE, '55', ANNO, 'Incarico di Direttore Generale, Amministrativo o Sanitario delle Aziende Sanitarie Locali ed Ospedaliere - solo D.M.A. 2' FROM P004_CODICITABANNUALI T
WHERE T.COD_TABANNUALE='IPTIPSERV' AND T.COD_CODICITABANNUALI='4' AND NOT EXISTS
(SELECT 'X' FROM P004_CODICITABANNUALI V
WHERE V.COD_TABANNUALE='IPTIPSERV' AND V.COD_CODICITABANNUALI='55');

INSERT INTO P004_CODICITABANNUALI
SELECT COD_TABANNUALE, '56', ANNO, 'Aspettativa per Dottorato di Ricerca - art. 2 della legge 476 del 13 agosto 1984 - solo D.M.A. 2' FROM P004_CODICITABANNUALI T
WHERE T.COD_TABANNUALE='IPTIPSERV' AND T.COD_CODICITABANNUALI='4' AND NOT EXISTS
(SELECT 'X' FROM P004_CODICITABANNUALI V
WHERE V.COD_TABANNUALE='IPTIPSERV' AND V.COD_CODICITABANNUALI='56');

UPDATE P094_INQUADRINPDAP T SET T.COD_TIPOSERVIZIO_ORDINARIO='55' WHERE T.COD_TIPOSERVIZIO_ORDINARIO='43';

--
-- Inizio creazione nuova assenza Aspettativa per Dottorato di Ricerca
--

declare 
  i integer;
  ID_P200 integer;
  CodVoceModello varchar2(5);
  CodVoceCopia varchar2(5);
  DesVoceCopia varchar2(40);
  DesVoceCopiaSt varchar2(40);

begin

CodVoceModello:='15150';
CodVoceCopia:='15160';
DesVoceCopia:='Dottorato di ricerca - onere amm.appart.';
DesVoceCopiaSt:='Dottorato di ricerca - onere amm.appart.';

select COUNT(*) into i from P200_VOCI t where T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND NOT EXISTS
  (select 'x' from P200_VOCI V WHERE V.COD_CONTRATTO='EDP' AND V.COD_VOCE=CodVoceCopia);
if i > 0 then

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, '', cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario, importo_massimo from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P205_QUOTE
select cod_contratto, CodVoceCopia, cod_voce_speciale_da_quotare, cod_voce_in_quota, cod_voce_speciale_in_quota, decorrenza, accumulo, accumulo_rateo, cod_voce_speciale_dettaglio
from p205_quote T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE_DA_QUOTARE=CodVoceModello AND T.COD_VOCE_SPECIALE_DA_QUOTARE='BASE';

INSERT INTO P206_ASSENZEINPDAP
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, elimina_sezione, abbatte_ggutili, cod_tiposervizio, cod_gestassic_noncoperte, cod_causasospensione, perc_asp_sindacale, perc_retribuzione, note, decorrenza_fine
from p206_assenzeinpdap T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

update p206_assenzeinpdap t set t.cod_tiposervizio='56'
where t.cod_contratto='EDP' and t.cod_voce=CodVoceCopia and t.cod_voce_speciale='BASE' and t.cod_tiposervizio='46';

end if;

end;

/

--
-- Fine creazione nuova assenza Aspettativa per Dottorato di Ricerca
--

-----
-- Inizio F24EP con dettaglio voci
-----

declare
  i integer;
begin
  select COUNT(*) into i from P660_FLUSSIREGOLE t where t.Nome_Flusso='F24EP';
  if i > 0 then
     DELETE P660_FLUSSIREGOLE t where t.Nome_Flusso='F24EP';

insert into P660_FLUSSIREGOLE (nome_flusso, decorrenza, parte, numero, descrizione, tipo_record, sezione_file, numero_file, formato_file, lunghezza_file, formato_annomese, numerico, cod_arrotondamento, formato, ometti_vuoto, tipo_dato, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, fl_numero_tredicesima, fl_numero_arrcorr, fl_numero_arrprec, nome_dato, codici_causali, fl_numero_tredprec)
values ('F24EP', to_date('01-01-2008', 'dd-mm-yyyy'), 'E', '001', 'IRPEF/IRAP prima parte', null, null, null, null, null, 'N', 'N', null, null, 'S', 'R', 
        'SELECT TIPO_RIGA, COD_TRIBUTO, COD_ENTE CODICE, '''' ESTREMI_IDENT,' || chr(10) || '       MESE RIFERIMENTO_A, ANNO RIFERIMENTO_B, COD_VOCE, COD_VOCE_SPECIALE, DESCRIZIONE,' || chr(10) || '       SUM(IMPORTO) IMPORTO FROM' || chr(10) || '(' || chr(10) || '-- IRPEF da competenze del mese' || chr(10) || 'SELECT ''01-IRPEF'' TIPO_TASSA, P441.PROGRESSIVO, ''F'' TIPO_RIGA,' || chr(10) || 'P200.COD_VOCE, P200.COD_VOCE_SPECIALE, P200.DESCRIZIONE,' || chr(10) || 'DECODE(P442.COD_VOCE||P442.COD_VOCE_SPECIALE,''11210BASE'',''100E'',''11220BASE'',''102E'',''11230BASE'',''110E'',''11520BASE'',''112E'',''11525BASE'',''145E'',' || chr(10) || '       ''11500BASE'',DECODE(P430.COD_CAUSALEIRPEF,''1045'',''106E'',''104E''),' || chr(10) || '       ''11210CONG'',DECODE(SIGN(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') - TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'')),1,''111E'',''100E'')) COD_TRIBUTO,' || chr(10) || ''''' COD_ENTE, ''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE,' || chr(10) || 'DECODE(P442.COD_VOCE||P442.COD_VOCE_SPECIALE,''11210CONG'',' || chr(10) || '       DECODE(SIGN(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') - TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'')),' || chr(10) || '              1,TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'')) - 1,TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY''))),' || chr(10) || '       TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY''))) ANNO,' || chr(10) || 'P442.IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442,' || chr(10) || '     P200_VOCI P200, P430_ANAGRAFICO P430' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND P441.PROGRESSIVO = P430.PROGRESSIVO AND P441.DATA_CEDOLINO BETWEEN P430.DECORRENZA AND P430.DECORRENZA_FINE' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini) AND P441.TIPO_CEDOLINO <> ''RP''' || chr(10) || 'AND P442.COD_VOCE||P442.COD_VOCE_SPECIALE IN (''11210BASE'',''11220BASE'',''11230BASE'',''11500BASE'',''11520BASE'',''11525BASE'',''11210CONG'')' || chr(10) || 'AND P442.TIPO_RECORD = ''M'' AND P200.ID_VOCE = P442.ID_VOCE' || chr(10) || 'UNION ALL' || chr(10) || '-- Addizionali IRPEF saldo e acconto' || chr(10) || 'SELECT ''01-IRPEF'' TIPO_TASSA, P441.PROGRESSIVO, DECODE(P258.TIPO_ADDIZIONALE,''R'',''R'',''C'',''S'') TIPO_RIGA,' || chr(10) || 'P200.COD_VOCE, P200.COD_VOCE_SPECIALE, P200.DESCRIZIONE,' || chr(10) || 'DECODE(P442.COD_VOCE,''11250'',''384E'',''11255'',''385E'',''11270'',''381E'') COD_TRIBUTO,' || chr(10) || 'P258.COD_ENTE, ''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE, P258.ANNO, P442.IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442,' || chr(10) || '     P200_VOCI P200, P258_ADDIZIONALIIRPEF P258' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO AND P441.PROGRESSIVO = P258.PROGRESSIVO' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini) AND P441.TIPO_CEDOLINO <> ''RP''' || chr(10) || 'AND P258.ANNO = TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'')' || chr(10) || 'AND P258.TIPO_ADDIZIONALE = DECODE(P442.COD_VOCE,''11250'',''C'',''11255'',''C'',''11270'',''R'')' || chr(10) || 'AND P258.TIPO_VERSAMENTO = DECODE(P442.COD_VOCE,''11250'',''S'',''11255'',''A'',''11270'',''S'')' || chr(10) || 'AND P442.COD_VOCE IN (''11250'',''11255'',''11270'')' || chr(10) || 'AND P442.COD_VOCE_SPECIALE = ''BASE'' AND P442.TIPO_RECORD = ''M'' AND P200.ID_VOCE = P442.ID_VOCE' || chr(10) || 'UNION ALL' || chr(10) || '', 
        'SELECT TIPO_RIGA, COD_TRIBUTO, COD_ENTE CODICE, '''' ESTREMI_IDENT,' || chr(10) || '       MESE RIFERIMENTO_A, ANNO RIFERIMENTO_B, COD_VOCE, COD_VOCE_SPECIALE, DESCRIZIONE,' || chr(10) || '       SUM(IMPORTO) IMPORTO FROM' || chr(10) || '(' || chr(10) || '-- IRPEF da competenze del mese' || chr(10) || 'SELECT ''01-IRPEF'' TIPO_TASSA, P441.PROGRESSIVO, ''F'' TIPO_RIGA,' || chr(10) || 'P200.COD_VOCE, P200.COD_VOCE_SPECIALE, P200.DESCRIZIONE,' || chr(10) || 'DECODE(P442.COD_VOCE||P442.COD_VOCE_SPECIALE,''11210BASE'',''100E'',''11220BASE'',''102E'',''11230BASE'',''110E'',''11520BASE'',''112E'',''11525BASE'',''145E'',' || chr(10) || '       ''11500BASE'',DECODE(P430.COD_CAUSALEIRPEF,''1045'',''106E'',''104E''),' || chr(10) || '       ''11210CONG'',DECODE(SIGN(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') - TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'')),1,''111E'',''100E'')) COD_TRIBUTO,' || chr(10) || ''''' COD_ENTE, ''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE,' || chr(10) || 'DECODE(P442.COD_VOCE||P442.COD_VOCE_SPECIALE,''11210CONG'',' || chr(10) || '       DECODE(SIGN(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') - TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'')),' || chr(10) || '              1,TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'')) - 1,TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY''))),' || chr(10) || '       TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY''))) ANNO,' || chr(10) || 'P442.IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442,' || chr(10) || '     P200_VOCI P200, P430_ANAGRAFICO P430' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND P441.PROGRESSIVO = P430.PROGRESSIVO AND P441.DATA_CEDOLINO BETWEEN P430.DECORRENZA AND P430.DECORRENZA_FINE' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini) AND P441.TIPO_CEDOLINO <> ''RP''' || chr(10) || 'AND P442.COD_VOCE||P442.COD_VOCE_SPECIALE IN (''11210BASE'',''11220BASE'',''11230BASE'',''11500BASE'',''11520BASE'',''11525BASE'',''11210CONG'')' || chr(10) || 'AND P442.TIPO_RECORD = ''M'' AND P200.ID_VOCE = P442.ID_VOCE' || chr(10) || 'UNION ALL' || chr(10) || '-- Addizionali IRPEF saldo e acconto' || chr(10) || 'SELECT ''01-IRPEF'' TIPO_TASSA, P441.PROGRESSIVO, DECODE(P258.TIPO_ADDIZIONALE,''R'',''R'',''C'',''S'') TIPO_RIGA,' || chr(10) || 'P200.COD_VOCE, P200.COD_VOCE_SPECIALE, P200.DESCRIZIONE,' || chr(10) || 'DECODE(P442.COD_VOCE,''11250'',''384E'',''11255'',''385E'',''11270'',''381E'') COD_TRIBUTO,' || chr(10) || 'P258.COD_ENTE, ''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE, P258.ANNO, P442.IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442,' || chr(10) || '     P200_VOCI P200, P258_ADDIZIONALIIRPEF P258' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO AND P441.PROGRESSIVO = P258.PROGRESSIVO' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini) AND P441.TIPO_CEDOLINO <> ''RP''' || chr(10) || 'AND P258.ANNO = TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'')' || chr(10) || 'AND P258.TIPO_ADDIZIONALE = DECODE(P442.COD_VOCE,''11250'',''C'',''11255'',''C'',''11270'',''R'')' || chr(10) || 'AND P258.TIPO_VERSAMENTO = DECODE(P442.COD_VOCE,''11250'',''S'',''11255'',''A'',''11270'',''S'')' || chr(10) || 'AND P442.COD_VOCE IN (''11250'',''11255'',''11270'')' || chr(10) || 'AND P442.COD_VOCE_SPECIALE = ''BASE'' AND P442.TIPO_RECORD = ''M'' AND P200.ID_VOCE = P442.ID_VOCE' || chr(10) || 'UNION ALL' || chr(10) || '', 
        'N', null, null, null, null, null, null, null);
insert into P660_FLUSSIREGOLE (nome_flusso, decorrenza, parte, numero, descrizione, tipo_record, sezione_file, numero_file, formato_file, lunghezza_file, formato_annomese, numerico, cod_arrotondamento, formato, ometti_vuoto, tipo_dato, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, fl_numero_tredicesima, fl_numero_arrcorr, fl_numero_arrprec, nome_dato, codici_causali, fl_numero_tredprec)
values ('F24EP', to_date('01-01-2008', 'dd-mm-yyyy'), 'E', '002', 'IRPEF/IRAP seconda parte', null, null, null, null, null, 'N', 'N', null, null, 'S', 'R', 
        '-- IRPEF da modello 730' || chr(10) || 'SELECT ''01-IRPEF'' TIPO_TASSA, P441.PROGRESSIVO, DECODE(P260.TIPO_ENTE,''N'',''F'',''R'',''R'',''C'',''S'') TIPO_RIGA,' || chr(10) || 'P200.COD_VOCE, P200.COD_VOCE_SPECIALE, P200.DESCRIZIONE,' || chr(10) || 'SUBSTR(P200.COD_CAUSALEIRPEF,4) COD_TRIBUTO,' || chr(10) || 'P264.COD_ENTE, ''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE,' || chr(10) || 'P260.ANNO + P260.ANNO_IMPOSTA ANNO,' || chr(10) || 'P442.IMPORTO * DECODE(P200.IMPORTO_COLONNA,''C'',-1,''R'',1) IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P200_VOCI P200,' || chr(10) || '     P260_MOD730TIPOIMPORTI P260, P264_MOD730IMPORTI P264,' || chr(10) || '     T480_COMUNI T480, T482_REGIONI T482' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini) AND P441.TIPO_CEDOLINO <> ''RP''' || chr(10) || 'AND P442.TIPO_RECORD = ''M'' AND P200.ID_VOCE = P442.ID_VOCE AND' || chr(10) || '(' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE) OR' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE_INT_RATE AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE_INT_RATE) OR' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE_INT_RITARDO AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE_INT_RITARDO)' || chr(10) || ') AND' || chr(10) || 'TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'') = P260.ANNO AND' || chr(10) || 'P260.ANNO = P264.ANNO AND P260.COD_TIPOIMPORTO = P264.COD_TIPOIMPORTO AND' || chr(10) || 'P264.PROGRESSIVO = P441.PROGRESSIVO AND' || chr(10) || 'P264.COD_ENTE = T480.CODCATASTALE(+) AND P264.COD_ENTE = T482.COD_REGIONE(+)' || chr(10) || 'UNION ALL' || chr(10) || '-- IRAP' || chr(10) || 'SELECT ''02-IRAP'' TIPO_TASSA, P441.PROGRESSIVO, ''R'' TIPO_RIGA,' || chr(10) || 'P200.COD_VOCE, P200.COD_VOCE_SPECIALE, P200.DESCRIZIONE,' || chr(10) || '''380E'' COD_TRIBUTO,' || chr(10) || '  (SELECT T482.COD_IRPEF FROM P500_CUDSETUP P500, T481_PROVINCE T481, T482_REGIONI T482' || chr(10) || '     WHERE P500.ANNO = TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') AND P500.PROVINCIA = T481.COD_PROVINCIA' || chr(10) || '     AND T481.COD_REGIONE = T482.COD_REGIONE)' || chr(10) || '  COD_ENTE,' || chr(10) || '''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE,' || chr(10) || 'TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'')) ANNO,' || chr(10) || 'P442.IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P200_VOCI P200' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini) AND P441.TIPO_CEDOLINO <> ''RP''' || chr(10) || 'AND P442.COD_VOCE IN (''11100'',''11102'')' || chr(10) || 'AND P442.COD_VOCE_SPECIALE = ''BASE'' AND P442.TIPO_RECORD = ''M'' AND P200.ID_VOCE = P442.ID_VOCE' || chr(10) || ')' || chr(10) || 'WHERE PROGRESSIVO IN (SELECT PROGRESSIVO FROM :C700SelAnagrafe)' || chr(10) || 'GROUP BY TIPO_TASSA, TIPO_RIGA, COD_TRIBUTO, COD_ENTE, MESE, ANNO, COD_VOCE, COD_VOCE_SPECIALE, DESCRIZIONE' || chr(10) || 'HAVING SUM(IMPORTO) <> 0' || chr(10) || 'ORDER BY TIPO_TASSA, TIPO_RIGA, COD_ENTE, COD_TRIBUTO, ANNO, COD_VOCE, COD_VOCE_SPECIALE, DESCRIZIONE' || chr(10) || '', 
        '-- IRPEF da modello 730' || chr(10) || 'SELECT ''01-IRPEF'' TIPO_TASSA, P441.PROGRESSIVO, DECODE(P260.TIPO_ENTE,''N'',''F'',''R'',''R'',''C'',''S'') TIPO_RIGA,' || chr(10) || 'P200.COD_VOCE, P200.COD_VOCE_SPECIALE, P200.DESCRIZIONE,' || chr(10) || 'SUBSTR(P200.COD_CAUSALEIRPEF,4) COD_TRIBUTO,' || chr(10) || 'P264.COD_ENTE, ''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE,' || chr(10) || 'P260.ANNO + P260.ANNO_IMPOSTA ANNO,' || chr(10) || 'P442.IMPORTO * DECODE(P200.IMPORTO_COLONNA,''C'',-1,''R'',1) IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P200_VOCI P200,' || chr(10) || '     P260_MOD730TIPOIMPORTI P260, P264_MOD730IMPORTI P264,' || chr(10) || '     T480_COMUNI T480, T482_REGIONI T482' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini) AND P441.TIPO_CEDOLINO <> ''RP''' || chr(10) || 'AND P442.TIPO_RECORD = ''M'' AND P200.ID_VOCE = P442.ID_VOCE AND' || chr(10) || '(' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE) OR' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE_INT_RATE AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE_INT_RATE) OR' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE_INT_RITARDO AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE_INT_RITARDO)' || chr(10) || ') AND' || chr(10) || 'TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'') = P260.ANNO AND' || chr(10) || 'P260.ANNO = P264.ANNO AND P260.COD_TIPOIMPORTO = P264.COD_TIPOIMPORTO AND' || chr(10) || 'P264.PROGRESSIVO = P441.PROGRESSIVO AND' || chr(10) || 'P264.COD_ENTE = T480.CODCATASTALE(+) AND P264.COD_ENTE = T482.COD_REGIONE(+)' || chr(10) || 'UNION ALL' || chr(10) || '-- IRAP' || chr(10) || 'SELECT ''02-IRAP'' TIPO_TASSA, P441.PROGRESSIVO, ''R'' TIPO_RIGA,' || chr(10) || 'P200.COD_VOCE, P200.COD_VOCE_SPECIALE, P200.DESCRIZIONE,' || chr(10) || '''380E'' COD_TRIBUTO,' || chr(10) || '  (SELECT T482.COD_IRPEF FROM P500_CUDSETUP P500, T481_PROVINCE T481, T482_REGIONI T482' || chr(10) || '     WHERE P500.ANNO = TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') AND P500.PROVINCIA = T481.COD_PROVINCIA' || chr(10) || '     AND T481.COD_REGIONE = T482.COD_REGIONE)' || chr(10) || '  COD_ENTE,' || chr(10) || '''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE,' || chr(10) || 'TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'')) ANNO,' || chr(10) || 'P442.IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P200_VOCI P200' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini) AND P441.TIPO_CEDOLINO <> ''RP''' || chr(10) || 'AND P442.COD_VOCE IN (''11100'',''11102'')' || chr(10) || 'AND P442.COD_VOCE_SPECIALE = ''BASE'' AND P442.TIPO_RECORD = ''M'' AND P200.ID_VOCE = P442.ID_VOCE' || chr(10) || ')' || chr(10) || 'WHERE PROGRESSIVO IN (SELECT PROGRESSIVO FROM :C700SelAnagrafe)' || chr(10) || 'GROUP BY TIPO_TASSA, TIPO_RIGA, COD_TRIBUTO, COD_ENTE, MESE, ANNO, COD_VOCE, COD_VOCE_SPECIALE, DESCRIZIONE' || chr(10) || 'HAVING SUM(IMPORTO) <> 0' || chr(10) || 'ORDER BY TIPO_TASSA, TIPO_RIGA, COD_ENTE, COD_TRIBUTO, ANNO, COD_VOCE, COD_VOCE_SPECIALE, DESCRIZIONE' || chr(10) || '', 
        'N', null, null, null, null, null, null, null);
insert into P660_FLUSSIREGOLE (nome_flusso, decorrenza, parte, numero, descrizione, tipo_record, sezione_file, numero_file, formato_file, lunghezza_file, formato_annomese, numerico, cod_arrotondamento, formato, ometti_vuoto, tipo_dato, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, fl_numero_tredicesima, fl_numero_arrcorr, fl_numero_arrprec, nome_dato, codici_causali, fl_numero_tredprec)
values ('F24EP', to_date('01-01-2008', 'dd-mm-yyyy'), 'I', '001', 'INPS DM10', null, null, null, null, null, 'N', 'N', null, null, 'S', 'R', 'SELECT ''I'' TIPO_RIGA, ''DM10'' COD_TRIBUTO, SEDE_INPS CODICE, MATRICOLA_INPS ESTREMI_IDENT, ' || chr(10) || '       TO_CHAR(:DataElaborazione,''MMYYYY'') RIFERIMENTO_A, '''' RIFERIMENTO_B,' || chr(10) || '       SUM(IMPORTO) IMPORTO FROM' || chr(10) || '(' || chr(10) || 'SELECT DECODE(P672.MATRICOLA_INPS,'''',P500.MATRICOLA_INPS,P672.MATRICOLA_INPS) MATRICOLA_INPS,' || chr(10) || '       P500.SEDE_INPS, DECODE(P673.NUMERO,''Z510'',1,''Z515'',-1) * P673.VALORE IMPORTO' || chr(10) || 'FROM P672_XMLTESTATE P672, P673_XMLDATIINDIVIDUALI P673, P500_CUDSETUP P500' || chr(10) || 'WHERE P672.NOME_FLUSSO = ''UNIEMENS'' AND P672.DATA_FINE_PERIODO = :DataElaborazione' || chr(10) || 'AND P672.Chiuso IN (:StatoUniemens) AND P672.ID_FLUSSO = P673.ID_FLUSSO' || chr(10) || 'AND P673.NUMERO IN (''Z510'',''Z515'') AND P673.TIPO_RECORD = ''M''' || chr(10) || 'AND P500.ANNO = TO_CHAR(:DataElaborazione,''YYYY'')' || chr(10) || ')' || chr(10) || 'GROUP BY SEDE_INPS, MATRICOLA_INPS' || chr(10) || 'ORDER BY MATRICOLA_INPS', 'SELECT ''I'' TIPO_RIGA, ''DM10'' COD_TRIBUTO, SEDE_INPS CODICE, MATRICOLA_INPS ESTREMI_IDENT, ' || chr(10) || '       TO_CHAR(:DataElaborazione,''MMYYYY'') RIFERIMENTO_A, '''' RIFERIMENTO_B,' || chr(10) || '       SUM(IMPORTO) IMPORTO FROM' || chr(10) || '(' || chr(10) || 'SELECT DECODE(P672.MATRICOLA_INPS,'''',P500.MATRICOLA_INPS,P672.MATRICOLA_INPS) MATRICOLA_INPS,' || chr(10) || '       P500.SEDE_INPS, DECODE(P673.NUMERO,''Z510'',1,''Z515'',-1) * P673.VALORE IMPORTO' || chr(10) || 'FROM P672_XMLTESTATE P672, P673_XMLDATIINDIVIDUALI P673, P500_CUDSETUP P500' || chr(10) || 'WHERE P672.NOME_FLUSSO = ''UNIEMENS'' AND P672.DATA_FINE_PERIODO = :DataElaborazione' || chr(10) || 'AND P672.Chiuso IN (:StatoUniemens) AND P672.ID_FLUSSO = P673.ID_FLUSSO' || chr(10) || 'AND P673.NUMERO IN (''Z510'',''Z515'') AND P673.TIPO_RECORD = ''M''' || chr(10) || 'AND P500.ANNO = TO_CHAR(:DataElaborazione,''YYYY'')' || chr(10) || ')' || chr(10) || 'GROUP BY SEDE_INPS, MATRICOLA_INPS' || chr(10) || 'ORDER BY MATRICOLA_INPS', 'N', null, null, null, null, null, null, null);
insert into P660_FLUSSIREGOLE (nome_flusso, decorrenza, parte, numero, descrizione, tipo_record, sezione_file, numero_file, formato_file, lunghezza_file, formato_annomese, numerico, cod_arrotondamento, formato, ometti_vuoto, tipo_dato, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, fl_numero_tredicesima, fl_numero_arrcorr, fl_numero_arrprec, nome_dato, codici_causali, fl_numero_tredprec)
values ('F24EP', to_date('01-01-2008', 'dd-mm-yyyy'), 'I', '002', 'INPS gestione separata', null, null, null, null, null, 'N', 'N', null, null, 'S', 'R', 'SELECT ''I'' TIPO_RIGA, COD_TRIBUTO, SEDE_INPS CODICE, CAP||COMUNE ESTREMI_IDENT, ' || chr(10) || '       TO_CHAR(:DataElaborazione,''MMYYYY'') RIFERIMENTO_A, '''' RIFERIMENTO_B,' || chr(10) || '       SUM(ROUND(IMPONIBILE * ALIQUOTA / 10000,2)) IMPORTO FROM' || chr(10) || '(' || chr(10) || 'SELECT P500.SEDE_INPS, TRIM(P500.CAP) CAP, TRIM(P500.COMUNE) COMUNE,' || chr(10) || '       DECODE(P430.COD_TIPOASSOGGETTAMENTO,''INPS1'',''C10'',''INPS2'',''CXX'',''INPS3'',''C10'') COD_TRIBUTO,' || chr(10) || '       P673.VALORE IMPONIBILE,' || chr(10) || '     NVL((SELECT P673A.VALORE FROM P673_XMLDATIINDIVIDUALI P673A WHERE P673A.ID_FLUSSO = P673.ID_FLUSSO' || chr(10) || '     AND P673A.PROGRESSIVO = P673.PROGRESSIVO' || chr(10) || '     AND P673A.PROGRESSIVO_NUMERO = P673.PROGRESSIVO_NUMERO AND P673A.TIPO_RECORD = P673.TIPO_RECORD' || chr(10) || '     AND P673A.NUMERO = ''C035''),0) ALIQUOTA' || chr(10) || 'FROM P672_XMLTESTATE P672, P673_XMLDATIINDIVIDUALI P673, P500_CUDSETUP P500, P430_ANAGRAFICO P430' || chr(10) || 'WHERE P672.NOME_FLUSSO = ''UNIEMENS'' AND P672.DATA_FINE_PERIODO = :DataElaborazione' || chr(10) || 'AND P672.Chiuso IN (:StatoUniemens) AND P672.ID_FLUSSO = P673.ID_FLUSSO' || chr(10) || 'AND P673.NUMERO = ''C030'' AND P673.TIPO_RECORD = ''M''' || chr(10) || 'AND P500.ANNO = TO_CHAR(:DataElaborazione,''YYYY'')' || chr(10) || 'AND P430.PROGRESSIVO = P673.PROGRESSIVO AND :DataElaborazione BETWEEN P430.DECORRENZA AND P430.DECORRENZA_FINE' || chr(10) || ')' || chr(10) || 'GROUP BY SEDE_INPS, CAP, COMUNE, COD_TRIBUTO' || chr(10) || 'ORDER BY COD_TRIBUTO', 
        'SELECT ''I'' TIPO_RIGA, COD_TRIBUTO, SEDE_INPS CODICE, CAP||COMUNE ESTREMI_IDENT, ' || chr(10) || '       TO_CHAR(:DataElaborazione,''MMYYYY'') RIFERIMENTO_A, '''' RIFERIMENTO_B,' || chr(10) || '       SUM(ROUND(IMPONIBILE * ALIQUOTA / 10000,2)) IMPORTO FROM' || chr(10) || '(' || chr(10) || 'SELECT P500.SEDE_INPS, TRIM(P500.CAP) CAP, TRIM(P500.COMUNE) COMUNE,' || chr(10) || '       DECODE(P430.COD_TIPOASSOGGETTAMENTO,''INPS1'',''C10'',''INPS2'',''CXX'',''INPS3'',''C10'') COD_TRIBUTO,' || chr(10) || '       P673.VALORE IMPONIBILE,' || chr(10) || '     NVL((SELECT P673A.VALORE FROM P673_XMLDATIINDIVIDUALI P673A WHERE P673A.ID_FLUSSO = P673.ID_FLUSSO' || chr(10) || '     AND P673A.PROGRESSIVO = P673.PROGRESSIVO' || chr(10) || '     AND P673A.PROGRESSIVO_NUMERO = P673.PROGRESSIVO_NUMERO AND P673A.TIPO_RECORD = P673.TIPO_RECORD' || chr(10) || '     AND P673A.NUMERO = ''C035''),0) ALIQUOTA' || chr(10) || 'FROM P672_XMLTESTATE P672, P673_XMLDATIINDIVIDUALI P673, P500_CUDSETUP P500, P430_ANAGRAFICO P430' || chr(10) || 'WHERE P672.NOME_FLUSSO = ''UNIEMENS'' AND P672.DATA_FINE_PERIODO = :DataElaborazione' || chr(10) || 'AND P672.Chiuso IN (:StatoUniemens) AND P672.ID_FLUSSO = P673.ID_FLUSSO' || chr(10) || 'AND P673.NUMERO = ''C030'' AND P673.TIPO_RECORD = ''M''' || chr(10) || 'AND P500.ANNO = TO_CHAR(:DataElaborazione,''YYYY'')' || chr(10) || 'AND P430.PROGRESSIVO = P673.PROGRESSIVO AND :DataElaborazione BETWEEN P430.DECORRENZA AND P430.DECORRENZA_FINE' || chr(10) || ')' || chr(10) || 'GROUP BY SEDE_INPS, CAP, COMUNE, COD_TRIBUTO' || chr(10) || 'ORDER BY COD_TRIBUTO', 'N', null, null, null, null, null, null, null);
insert into P660_FLUSSIREGOLE (nome_flusso, decorrenza, parte, numero, descrizione, tipo_record, sezione_file, numero_file, formato_file, lunghezza_file, formato_annomese, numerico, cod_arrotondamento, formato, ometti_vuoto, tipo_dato, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, fl_numero_tredicesima, fl_numero_arrcorr, fl_numero_arrprec, nome_dato, codici_causali, fl_numero_tredprec)
values ('F24EP', to_date('01-01-2008', 'dd-mm-yyyy'), 'P', '001', 'INPGI dipendenti', null, null, null, null, null, 'N', 'N', null, null, 'S', 'R', 'SELECT TIPO_RIGA, COD_TRIBUTO, '''' CODICE, COD_AZIENDA ESTREMI_IDENT,' || chr(10) || '       MESE RIFERIMENTO_A, ANNO RIFERIMENTO_B, COD_VOCE, COD_VOCE_SPECIALE, DESCRIZIONE,' || chr(10) || '       SUM(IMPORTO) IMPORTO FROM' || chr(10) || '(' || chr(10) || 'SELECT P441.PROGRESSIVO, ''P'' TIPO_RIGA,' || chr(10) || 'P200.COD_VOCE, P200.COD_VOCE_SPECIALE, P200.DESCRIZIONE,' || chr(10) || 'SUBSTR(P216.COD_CODICIACCORPAMENTOVOCI,10) COD_TRIBUTO,' || chr(10) || '  (SELECT P500.CODICE_AZIENDA_INPGI FROM P500_CUDSETUP P500' || chr(10) || '     WHERE P500.ANNO = TO_CHAR(P441.DATA_CEDOLINO,''YYYY''))' || chr(10) || '  COD_AZIENDA,' || chr(10) || '''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE,' || chr(10) || 'TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'')) ANNO,' || chr(10) || 'P442.IMPORTO*P216.PERCENTUALE/100 IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P200_VOCI P200, P216_ACCORPAMENTOVOCI P216' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO AND P442.ID_VOCE = P200.ID_VOCE' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini) AND P441.TIPO_CEDOLINO <> ''RP''' || chr(10) || 'AND P216.COD_CONTRATTO = P200.COD_CONTRATTO AND P216.COD_VOCE = P200.COD_VOCE AND P216.COD_VOCE_SPECIALE = P200.COD_VOCE_SPECIALE' || chr(10) || 'AND P442.DATA_COMPETENZA_A BETWEEN P216.DECORRENZA AND P216.DECORRENZA_FINE' || chr(10) || 'AND P216.COD_TIPOACCORPAMENTOVOCI = ''CU770'' AND SUBSTR(P216.COD_CODICIACCORPAMENTOVOCI,1,9) = ''F24INPGI-''' || chr(10) || 'AND P442.TIPO_RECORD = ''M''' || chr(10) || ')' || chr(10) || 'WHERE PROGRESSIVO IN (SELECT PROGRESSIVO FROM :C700SelAnagrafe)' || chr(10) || 'GROUP BY TIPO_RIGA, COD_TRIBUTO, COD_AZIENDA, MESE, ANNO, COD_VOCE, COD_VOCE_SPECIALE, DESCRIZIONE' || chr(10) || 'HAVING SUM(IMPORTO) <> 0' || chr(10) || 'ORDER BY TIPO_RIGA, COD_TRIBUTO, COD_AZIENDA, ANNO, COD_VOCE, COD_VOCE_SPECIALE, DESCRIZIONE' || chr(10) || '', 
        'SELECT TIPO_RIGA, COD_TRIBUTO, '''' CODICE, COD_AZIENDA ESTREMI_IDENT,' || chr(10) || '       MESE RIFERIMENTO_A, ANNO RIFERIMENTO_B, COD_VOCE, COD_VOCE_SPECIALE, DESCRIZIONE,' || chr(10) || '       SUM(IMPORTO) IMPORTO FROM' || chr(10) || '(' || chr(10) || 'SELECT P441.PROGRESSIVO, ''P'' TIPO_RIGA,' || chr(10) || 'P200.COD_VOCE, P200.COD_VOCE_SPECIALE, P200.DESCRIZIONE,' || chr(10) || 'SUBSTR(P216.COD_CODICIACCORPAMENTOVOCI,10) COD_TRIBUTO,' || chr(10) || '  (SELECT P500.CODICE_AZIENDA_INPGI FROM P500_CUDSETUP P500' || chr(10) || '     WHERE P500.ANNO = TO_CHAR(P441.DATA_CEDOLINO,''YYYY''))' || chr(10) || '  COD_AZIENDA,' || chr(10) || '''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE,' || chr(10) || 'TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'')) ANNO,' || chr(10) || 'P442.IMPORTO*P216.PERCENTUALE/100 IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P200_VOCI P200, P216_ACCORPAMENTOVOCI P216' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO AND P442.ID_VOCE = P200.ID_VOCE' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini) AND P441.TIPO_CEDOLINO <> ''RP''' || chr(10) || 'AND P216.COD_CONTRATTO = P200.COD_CONTRATTO AND P216.COD_VOCE = P200.COD_VOCE AND P216.COD_VOCE_SPECIALE = P200.COD_VOCE_SPECIALE' || chr(10) || 'AND P442.DATA_COMPETENZA_A BETWEEN P216.DECORRENZA AND P216.DECORRENZA_FINE' || chr(10) || 'AND P216.COD_TIPOACCORPAMENTOVOCI = ''CU770'' AND SUBSTR(P216.COD_CODICIACCORPAMENTOVOCI,1,9) = ''F24INPGI-''' || chr(10) || 'AND P442.TIPO_RECORD = ''M''' || chr(10) || ')' || chr(10) || 'WHERE PROGRESSIVO IN (SELECT PROGRESSIVO FROM :C700SelAnagrafe)' || chr(10) || 'GROUP BY TIPO_RIGA, COD_TRIBUTO, COD_AZIENDA, MESE, ANNO, COD_VOCE, COD_VOCE_SPECIALE, DESCRIZIONE' || chr(10) || 'HAVING SUM(IMPORTO) <> 0' || chr(10) || 'ORDER BY TIPO_RIGA, COD_TRIBUTO, COD_AZIENDA, ANNO, COD_VOCE, COD_VOCE_SPECIALE, DESCRIZIONE' || chr(10) || '', 'N', null, null, null, null, null, null, null);
insert into P660_FLUSSIREGOLE (nome_flusso, decorrenza, parte, numero, descrizione, tipo_record, sezione_file, numero_file, formato_file, lunghezza_file, formato_annomese, numerico, cod_arrotondamento, formato, ometti_vuoto, tipo_dato, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, fl_numero_tredicesima, fl_numero_arrcorr, fl_numero_arrprec, nome_dato, codici_causali, fl_numero_tredprec)
values ('F24EP', to_date('01-01-2008', 'dd-mm-yyyy'), 'Q', '001', 'INPDAP', null, null, null, null, null, 'N', 'N', null, null, 'S', 'R', 
        'SELECT ''Q'' TIPO_RIGA, ''P''||CASSA||CAUSALE COD_TRIBUTO,' || chr(10) || '       (SELECT TRIM(UPPER(P500.PROVINCIA)) FROM P500_CUDSETUP P500 WHERE P500.ANNO = TO_CHAR(:DataElaborazione,''YYYY'')) CODICE,' || chr(10) || '       '''' ESTREMI_IDENT, TO_CHAR(:DataElaborazione,''MMYYYY'') RIFERIMENTO_A, TO_CHAR(:DataElaborazione,''MMYYYY'') RIFERIMENTO_B, IMPORTO FROM' || chr(10) || '(' || chr(10) || 'SELECT PROGRESSIVO_NUMERO, CASSA, CAUSALE, SUM(VALORE) IMPORTO FROM' || chr(10) || '(' || chr(10) || 'SELECT P663.PROGRESSIVO_NUMERO,' || chr(10) || '  (SELECT P663A.VALORE FROM P663_FLUSSIDATIINDIVIDUALI P663A WHERE P663A.ID_FLUSSO = P663.ID_FLUSSO' || chr(10) || '     AND P663A.PROGRESSIVO = P663.PROGRESSIVO AND P663A.PARTE = P663.PARTE' || chr(10) || '     AND P663A.PROGRESSIVO_NUMERO = P663.PROGRESSIVO_NUMERO AND P663A.TIPO_RECORD = P663.TIPO_RECORD' || chr(10) || '     AND P663A.NUMERO = ''001'') CASSA,' || chr(10) || '  P660.CODICI_CAUSALI CAUSALE,' || chr(10) || '  P663.VALORE' || chr(10) || 'FROM P662_FLUSSITESTATE P662, P663_FLUSSIDATIINDIVIDUALI P663, P660_FLUSSIREGOLE P660' || chr(10) || 'WHERE P662.NOME_FLUSSO = ''DMA'' AND P662.DATA_FINE_PERIODO = :DataElaborazione' || chr(10) || 'AND P662.Chiuso IN (:StatoDMA) AND P662.ID_FLUSSO = P663.ID_FLUSSO' || chr(10) || 'AND P663.PARTE = ''Z2'' AND P663.TIPO_RECORD = ''M'' AND EXISTS' || chr(10) || '  (SELECT ''X'' FROM P663_FLUSSIDATIINDIVIDUALI P663B WHERE P663B.ID_FLUSSO = P663.ID_FLUSSO' || chr(10) || '   AND P663B.PROGRESSIVO = P663.PROGRESSIVO AND P663B.PARTE = P663.PARTE' || chr(10) || '   AND P663B.PROGRESSIVO_NUMERO = P663.PROGRESSIVO_NUMERO AND P663B.TIPO_RECORD = P663.TIPO_RECORD' || chr(10) || '   AND P663B.NUMERO = ''003'' AND P663B.VALORE = ''31'')' || chr(10) || 'AND P660.NOME_FLUSSO = P662.NOME_FLUSSO AND P660.PARTE = P663.PARTE  ' || chr(10) || 'AND P660.NUMERO = P663.NUMERO ' || chr(10) || 'AND P660.DECORRENZA = (SELECT MAX(DECORRENZA) FROM P660_FLUSSIREGOLE P660A ' || chr(10) || '                       WHERE P660.NOME_FLUSSO = P660A.NOME_FLUSSO AND P660.PARTE = P660A.PARTE ' || chr(10) || '                       AND P660.NUMERO = P660A.NUMERO AND P660A.DECORRENZA <= :DataElaborazione)' || chr(10) || 'AND P660.CODICI_CAUSALI IS NOT NULL AND P663.NUMERO <> ''021''' || chr(10) || '' || chr(10) || 'UNION ALL' || chr(10) || '' || chr(10) || 'SELECT 10000 PROGRESSIVO_NUMERO,' || chr(10) || '(SELECT VALORE FROM P663_FLUSSIDATIINDIVIDUALI WHERE ID_FLUSSO = P663.ID_FLUSSO ' || chr(10) || '    AND PROGRESSIVO = P663.PROGRESSIVO AND PARTE = P663.PARTE AND NUMERO = ''002'' ' || chr(10) || '    AND PROGRESSIVO_NUMERO = P663.PROGRESSIVO_NUMERO AND TIPO_RECORD = P663.TIPO_RECORD) CASSA,' || chr(10) || '(SELECT VALORE FROM P663_FLUSSIDATIINDIVIDUALI WHERE ID_FLUSSO = P663.ID_FLUSSO ' || chr(10) || '   AND PROGRESSIVO = P663.PROGRESSIVO AND PARTE = P663.PARTE AND NUMERO = ''003'' ' || chr(10) || '   AND PROGRESSIVO_NUMERO = P663.PROGRESSIVO_NUMERO AND TIPO_RECORD = P663.TIPO_RECORD) CAUSALE,' || chr(10) || 'DECODE((SELECT VALORE FROM P663_FLUSSIDATIINDIVIDUALI WHERE ID_FLUSSO = P663.ID_FLUSSO ' || chr(10) || '   AND PROGRESSIVO = P663.PROGRESSIVO AND PARTE = P663.PARTE AND NUMERO = ''007'' ' || chr(10) || '   AND PROGRESSIVO_NUMERO = P663.PROGRESSIVO_NUMERO AND TIPO_RECORD = P663.TIPO_RECORD),''V'',VALORE,''R'',-VALORE) IMPORTO' || chr(10) || 'FROM P662_FLUSSITESTATE P662, P663_FLUSSIDATIINDIVIDUALI P663' || chr(10) || 'WHERE P662.NOME_FLUSSO = ''DMA'' AND P662.DATA_FINE_PERIODO = :DataElaborazione' || chr(10) || 'AND P662.Chiuso IN (:StatoDMA) AND P662.ID_FLUSSO = P663.ID_FLUSSO' || chr(10) || 'AND TIPO_RECORD = ''M'' AND PARTE = ''F1'' AND NUMERO = ''005''' || chr(10) || 'AND (SELECT VALORE FROM P663_FLUSSIDATIINDIVIDUALI WHERE ID_FLUSSO = P663.ID_FLUSSO ' || chr(10) || '    AND PROGRESSIVO = P663.PROGRESSIVO AND PARTE = P663.PARTE AND NUMERO = ''003'' ' || chr(10) || '    AND PROGRESSIVO_NUMERO = P663.PROGRESSIVO_NUMERO AND TIPO_RECORD = P663.TIPO_RECORD) IN (''12'',''41'')' || chr(10) || ')' || chr(10) || 'GROUP BY PROGRESSIVO_NUMERO, CASSA, CAUSALE' || chr(10) || 'ORDER BY PROGRESSIVO_NUMERO, CASSA, CAUSALE' || chr(10) || ')', 
        'SELECT ''Q'' TIPO_RIGA, ''P''||CASSA||CAUSALE COD_TRIBUTO,' || chr(10) || '       (SELECT TRIM(UPPER(P500.PROVINCIA)) FROM P500_CUDSETUP P500 WHERE P500.ANNO = TO_CHAR(:DataElaborazione,''YYYY'')) CODICE,' || chr(10) || '       '''' ESTREMI_IDENT, TO_CHAR(:DataElaborazione,''MMYYYY'') RIFERIMENTO_A, TO_CHAR(:DataElaborazione,''MMYYYY'') RIFERIMENTO_B, IMPORTO FROM' || chr(10) || '(' || chr(10) || 'SELECT PROGRESSIVO_NUMERO, CASSA, CAUSALE, SUM(VALORE) IMPORTO FROM' || chr(10) || '(' || chr(10) || 'SELECT P663.PROGRESSIVO_NUMERO,' || chr(10) || '  (SELECT P663A.VALORE FROM P663_FLUSSIDATIINDIVIDUALI P663A WHERE P663A.ID_FLUSSO = P663.ID_FLUSSO' || chr(10) || '     AND P663A.PROGRESSIVO = P663.PROGRESSIVO AND P663A.PARTE = P663.PARTE' || chr(10) || '     AND P663A.PROGRESSIVO_NUMERO = P663.PROGRESSIVO_NUMERO AND P663A.TIPO_RECORD = P663.TIPO_RECORD' || chr(10) || '     AND P663A.NUMERO = ''001'') CASSA,' || chr(10) || '  P660.CODICI_CAUSALI CAUSALE,' || chr(10) || '  P663.VALORE' || chr(10) || 'FROM P662_FLUSSITESTATE P662, P663_FLUSSIDATIINDIVIDUALI P663, P660_FLUSSIREGOLE P660' || chr(10) || 'WHERE P662.NOME_FLUSSO = ''DMA'' AND P662.DATA_FINE_PERIODO = :DataElaborazione' || chr(10) || 'AND P662.Chiuso IN (:StatoDMA) AND P662.ID_FLUSSO = P663.ID_FLUSSO' || chr(10) || 'AND P663.PARTE = ''Z2'' AND P663.TIPO_RECORD = ''M'' AND EXISTS' || chr(10) || '  (SELECT ''X'' FROM P663_FLUSSIDATIINDIVIDUALI P663B WHERE P663B.ID_FLUSSO = P663.ID_FLUSSO' || chr(10) || '   AND P663B.PROGRESSIVO = P663.PROGRESSIVO AND P663B.PARTE = P663.PARTE' || chr(10) || '   AND P663B.PROGRESSIVO_NUMERO = P663.PROGRESSIVO_NUMERO AND P663B.TIPO_RECORD = P663.TIPO_RECORD' || chr(10) || '   AND P663B.NUMERO = ''003'' AND P663B.VALORE = ''31'')' || chr(10) || 'AND P660.NOME_FLUSSO = P662.NOME_FLUSSO AND P660.PARTE = P663.PARTE  ' || chr(10) || 'AND P660.NUMERO = P663.NUMERO ' || chr(10) || 'AND P660.DECORRENZA = (SELECT MAX(DECORRENZA) FROM P660_FLUSSIREGOLE P660A ' || chr(10) || '                       WHERE P660.NOME_FLUSSO = P660A.NOME_FLUSSO AND P660.PARTE = P660A.PARTE ' || chr(10) || '                       AND P660.NUMERO = P660A.NUMERO AND P660A.DECORRENZA <= :DataElaborazione)' || chr(10) || 'AND P660.CODICI_CAUSALI IS NOT NULL AND P663.NUMERO <> ''021''' || chr(10) || '' || chr(10) || 'UNION ALL' || chr(10) || '' || chr(10) || 'SELECT 10000 PROGRESSIVO_NUMERO,' || chr(10) || '(SELECT VALORE FROM P663_FLUSSIDATIINDIVIDUALI WHERE ID_FLUSSO = P663.ID_FLUSSO ' || chr(10) || '    AND PROGRESSIVO = P663.PROGRESSIVO AND PARTE = P663.PARTE AND NUMERO = ''002'' ' || chr(10) || '    AND PROGRESSIVO_NUMERO = P663.PROGRESSIVO_NUMERO AND TIPO_RECORD = P663.TIPO_RECORD) CASSA,' || chr(10) || '(SELECT VALORE FROM P663_FLUSSIDATIINDIVIDUALI WHERE ID_FLUSSO = P663.ID_FLUSSO ' || chr(10) || '   AND PROGRESSIVO = P663.PROGRESSIVO AND PARTE = P663.PARTE AND NUMERO = ''003'' ' || chr(10) || '   AND PROGRESSIVO_NUMERO = P663.PROGRESSIVO_NUMERO AND TIPO_RECORD = P663.TIPO_RECORD) CAUSALE,' || chr(10) || 'DECODE((SELECT VALORE FROM P663_FLUSSIDATIINDIVIDUALI WHERE ID_FLUSSO = P663.ID_FLUSSO ' || chr(10) || '   AND PROGRESSIVO = P663.PROGRESSIVO AND PARTE = P663.PARTE AND NUMERO = ''007'' ' || chr(10) || '   AND PROGRESSIVO_NUMERO = P663.PROGRESSIVO_NUMERO AND TIPO_RECORD = P663.TIPO_RECORD),''V'',VALORE,''R'',-VALORE) IMPORTO' || chr(10) || 'FROM P662_FLUSSITESTATE P662, P663_FLUSSIDATIINDIVIDUALI P663' || chr(10) || 'WHERE P662.NOME_FLUSSO = ''DMA'' AND P662.DATA_FINE_PERIODO = :DataElaborazione' || chr(10) || 'AND P662.Chiuso IN (:StatoDMA) AND P662.ID_FLUSSO = P663.ID_FLUSSO' || chr(10) || 'AND TIPO_RECORD = ''M'' AND PARTE = ''F1'' AND NUMERO = ''005''' || chr(10) || 'AND (SELECT VALORE FROM P663_FLUSSIDATIINDIVIDUALI WHERE ID_FLUSSO = P663.ID_FLUSSO ' || chr(10) || '    AND PROGRESSIVO = P663.PROGRESSIVO AND PARTE = P663.PARTE AND NUMERO = ''003'' ' || chr(10) || '    AND PROGRESSIVO_NUMERO = P663.PROGRESSIVO_NUMERO AND TIPO_RECORD = P663.TIPO_RECORD) IN (''12'',''41'')' || chr(10) || ')' || chr(10) || 'GROUP BY PROGRESSIVO_NUMERO, CASSA, CAUSALE' || chr(10) || 'ORDER BY PROGRESSIVO_NUMERO, CASSA, CAUSALE' || chr(10) || ')', 
        'N', null, null, null, null, null, null, null);
insert into P660_FLUSSIREGOLE (nome_flusso, decorrenza, parte, numero, descrizione, tipo_record, sezione_file, numero_file, formato_file, lunghezza_file, formato_annomese, numerico, cod_arrotondamento, formato, ometti_vuoto, tipo_dato, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, fl_numero_tredicesima, fl_numero_arrcorr, fl_numero_arrprec, nome_dato, codici_causali, fl_numero_tredprec)
values ('F24EP', to_date('01-10-2012', 'dd-mm-yyyy'), 'Q', '001', 'INPDAP', null, null, null, null, null, 'N', 'N', null, null, 'S', 'R', 'SELECT ''Q'' TIPO_RIGA, ''P''||CASSA||CAUSALE COD_TRIBUTO,' || chr(10) || '       (SELECT TRIM(UPPER(P500.PROVINCIA)) FROM P500_CUDSETUP P500 WHERE P500.ANNO = TO_CHAR(:DataElaborazione,''YYYY'')) CODICE,' || chr(10) || '       '''' ESTREMI_IDENT, TO_CHAR(:DataElaborazione,''MMYYYY'') RIFERIMENTO_A, TO_CHAR(:DataElaborazione,''MMYYYY'') RIFERIMENTO_B, IMPORTO FROM' || chr(10) || '(' || chr(10) || 'SELECT PROGRESSIVO_NUMERO, CASSA, CAUSALE, VALORE IMPORTO FROM' || chr(10) || '(' || chr(10) || 'SELECT P673.PROGRESSIVO_NUMERO, ' || chr(10) || '  (SELECT P673A.VALORE FROM P673_XMLDATIINDIVIDUALI P673A WHERE P673A.ID_FLUSSO = P673.ID_FLUSSO' || chr(10) || '     AND P673A.PROGRESSIVO = P673.PROGRESSIVO ' || chr(10) || '     AND P673A.PROGRESSIVO_NUMERO = P673.PROGRESSIVO_NUMERO AND P673A.TIPO_RECORD = P673.TIPO_RECORD' || chr(10) || '     AND P673A.NUMERO = ''Z870'') CASSA, P670.ATTRIBUTO CAUSALE, P673.VALORE' || chr(10) || 'FROM P672_XMLTESTATE P672, P673_XMLDATIINDIVIDUALI P673, P670_XMLREGOLE P670' || chr(10) || 'WHERE P672.NOME_FLUSSO = ''UNIEMENS'' AND P672.DATA_FINE_PERIODO = :DataElaborazione AND P672.CHIUSO IN (:StatoDMA) ' || chr(10) || 'AND P672.ID_FLUSSO = P673.ID_FLUSSO' || chr(10) || 'AND P673.TIPO_RECORD = ''M'' ' || chr(10) || 'AND P672.NOME_FLUSSO = P670.NOME_FLUSSO AND P673.NUMERO = P670.NUMERO ' || chr(10) || 'AND P670.NUMERO_PADRE = ''Z845'' AND P670.ATTRIBUTO IS NOT NULL ' || chr(10) || 'AND :DataElaborazione BETWEEN P670.DECORRENZA AND P670.DECORRENZA_FINE' || chr(10) || ')' || chr(10) || 'ORDER BY PROGRESSIVO_NUMERO, CASSA, CAUSALE' || chr(10) || ')', 
        'SELECT ''Q'' TIPO_RIGA, ''P''||CASSA||CAUSALE COD_TRIBUTO,' || chr(10) || '       (SELECT TRIM(UPPER(P500.PROVINCIA)) FROM P500_CUDSETUP P500 WHERE P500.ANNO = TO_CHAR(:DataElaborazione,''YYYY'')) CODICE,' || chr(10) || '       '''' ESTREMI_IDENT, TO_CHAR(:DataElaborazione,''MMYYYY'') RIFERIMENTO_A, TO_CHAR(:DataElaborazione,''MMYYYY'') RIFERIMENTO_B, IMPORTO FROM' || chr(10) || '(' || chr(10) || 'SELECT PROGRESSIVO_NUMERO, CASSA, CAUSALE, VALORE IMPORTO FROM' || chr(10) || '(' || chr(10) || 'SELECT P673.PROGRESSIVO_NUMERO, ' || chr(10) || '  (SELECT P673A.VALORE FROM P673_XMLDATIINDIVIDUALI P673A WHERE P673A.ID_FLUSSO = P673.ID_FLUSSO' || chr(10) || '     AND P673A.PROGRESSIVO = P673.PROGRESSIVO ' || chr(10) || '     AND P673A.PROGRESSIVO_NUMERO = P673.PROGRESSIVO_NUMERO AND P673A.TIPO_RECORD = P673.TIPO_RECORD' || chr(10) || '     AND P673A.NUMERO = ''Z870'') CASSA, P670.ATTRIBUTO CAUSALE, P673.VALORE' || chr(10) || 'FROM P672_XMLTESTATE P672, P673_XMLDATIINDIVIDUALI P673, P670_XMLREGOLE P670' || chr(10) || 'WHERE P672.NOME_FLUSSO = ''UNIEMENS'' AND P672.DATA_FINE_PERIODO = :DataElaborazione AND P672.CHIUSO IN (:StatoDMA) ' || chr(10) || 'AND P672.ID_FLUSSO = P673.ID_FLUSSO' || chr(10) || 'AND P673.TIPO_RECORD = ''M'' ' || chr(10) || 'AND P672.NOME_FLUSSO = P670.NOME_FLUSSO AND P673.NUMERO = P670.NUMERO ' || chr(10) || 'AND P670.NUMERO_PADRE = ''Z845'' AND P670.ATTRIBUTO IS NOT NULL ' || chr(10) || 'AND :DataElaborazione BETWEEN P670.DECORRENZA AND P670.DECORRENZA_FINE' || chr(10) || ')' || chr(10) || 'ORDER BY PROGRESSIVO_NUMERO, CASSA, CAUSALE' || chr(10) || ')', 'N', null, null, null, null, null, null, null);

  end if;
end;

/

-----
-- Fine F24EP con dettaglio voci
-----

-- CREAZIONE VOCE Variaz.imponibile ENPAM ex convenzionati
declare 
  i integer;
  ID_P200 integer;
  CodVoceModello varchar2(5);
  CodVoceCopia varchar2(5);
  DesVoceCopia varchar2(40);
  DesVoceCopiaSt varchar2(40);

begin
CodVoceModello:='10101';
CodVoceCopia:='10411';
DesVoceCopia:='Variaz.imponibile ENPAM ex convenzionati';
DesVoceCopiaSt:='Variaz.imponibile ENPAM ex convenzionati';

select COUNT(*) into i from P441_CEDOLINO;
if i > 0 then
  select COUNT(*) into i from P200_VOCI t 
    where T.COD_CONTRATTO ='EDP' and T.COD_VOCE=CodVoceModello and T.COD_VOCE_SPECIALE='BASE'
    and exists
    (select 'X' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce='10410'
       and v.cod_voce_speciale=t.cod_voce_speciale)
    and not exists
    (select 'X' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce=CodVoceCopia
       and v.cod_voce_speciale=t.cod_voce_speciale);
  if i > 0 then

-----
-- Inizio Variaz.imponibile ENPAM ex convenzionati 
-----
  
    SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
    insert into p200_voci
    select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario, importo_massimo from p200_voci T
    WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

    INSERT INTO P201_ASSOGGETTAMENTI
    select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, '10410', cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
    where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';


  end if;
end if;
end;
/

-----
-- Fine Variaz.imponibile ENPAM ex convenzionati
-----

UPDATE P430_ANAGRAFICO T SET T.COD_CAUSALEIRPEF='1001'
WHERE T.TIPO_DIPENDENTE='ER' AND T.COD_CAUSALEIRPEF='1002';

