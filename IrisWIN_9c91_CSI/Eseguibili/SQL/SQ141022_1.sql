alter table T065_RICHIESTESTRAORDINARI add MIN_ORE_DACOMPENSARE varchar2(6);
comment on column T065_RICHIESTESTRAORDINARI.MIN_ORE_DACOMPENSARE is 'ore minime da richiedere in compensazione: ORE_DACOMPENSARE deve essere >= MIN_ORE_DACOMPENSARE';

insert into MONDOEDP.I073_FILTROFUNZIONI (AZIENDA,APPLICAZIONE,PROFILO,TAG,INIBIZIONE)
select distinct AZIENDA,APPLICAZIONE,PROFILO,152,'S' 
from MONDOEDP.I073_FILTROFUNZIONI 
where APPLICAZIONE <> 'FUNWEB'
and :AZIENDA = 'AZIN';

delete from MONDOEDP.I073_FILTROFUNZIONI where TAG = 52 and :AZIENDA = 'AZIN';

update MONDOEDP.I073_FILTROFUNZIONI set FUNZIONE = 'OpenA077GeneratoreStampe' where TAG = 139 and :AZIENDA = 'AZIN';

-----
-- Regole 770 per utilizzare codice IRPEF anzichè codice regione
-----

declare
  i integer;
begin
  select COUNT(*) into i from P602_770REGOLE;
  if i > 0 then
     DELETE P602_770REGOLE t WHERE ANNO=2013 AND NUMERO='001' AND PARTE IN ('SX07','ST02');

insert into P602_770REGOLE (anno, parte, numero, tipo_record, sezione_file, formato_file, parte_cud, numero_cud, descrizione, numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, formato_annomese, numero_file, cod_arrotondamento_file)
values (2013, 'ST02', '001', 'E', 'ST', 'N6', null, null, 'Addizionale regionale - Periodo di riferimento', 'N', null, null, 'S', 
        'SELECT Q.*,' || chr(10) || '       DECODE(VERSATO,''0'','''',' || chr(10) || '                          DECODE(MESE_CED,''01'',P500.DATA_VERS_IRPEF01,''02'',P500.DATA_VERS_IRPEF02,''03'',P500.DATA_VERS_IRPEF03,' || chr(10) || '                                          ''04'',P500.DATA_VERS_IRPEF04,''05'',P500.DATA_VERS_IRPEF05,''06'',P500.DATA_VERS_IRPEF06,' || chr(10) || '                                          ''07'',P500.DATA_VERS_IRPEF07,''08'',P500.DATA_VERS_IRPEF08,''09'',P500.DATA_VERS_IRPEF09,' || chr(10) || '                                          ''10'',P500.DATA_VERS_IRPEF10,''11'',P500.DATA_VERS_IRPEF11,''12'',P500.DATA_VERS_IRPEF12))' || chr(10) || '       DATA_VERSAMENTO FROM' || chr(10) || '(' || chr(10) || '-- Query con dati finali tranne che data versamento' || chr(10) || 'SELECT MESE_CED, ANNO_CED, MESE_CED||ANNO_CED PERIODO_RIF,' || chr(10) || '       COD_TRIBUTO, COD_ENTE, ANNO_COMP,' || chr(10) || '       SUM(RITENUTA) RITENUTA, SUM(SCOMPUTO) SCOMPUTO, SUM(RITENUTA) - SUM(SCOMPUTO) VERSATO,' || chr(10) || '       DECODE(ANNO_COMP,:Anno,''S'','''') NOTE FROM' || chr(10) || '(' || chr(10) || '-- Query di dettaglio' || chr(10) || '-- Addizionali regionali saldo' || chr(10) || 'SELECT P441.PROGRESSIVO, TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE_CED, TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') ANNO_CED,' || chr(10) || '''381E'' COD_TRIBUTO, T482.COD_IRPEF COD_ENTE,' || chr(10) || 'TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'') ANNO_COMP,' || chr(10) || 'P442.IMPORTO RITENUTA, 0 SCOMPUTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P258_ADDIZIONALIIRPEF P258, T482_REGIONI T482' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO AND P441.PROGRESSIVO = P258.PROGRESSIVO AND T482.COD_REGIONE = P258.COD_ENTE' || chr(10) || 'AND TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') = :Anno AND P441.CHIUSO = ''S'' AND P441.TIPO_CEDOLINO <> ''RP''' || chr(10) || 'AND P258.ANNO = TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'')' || chr(10) || 'AND P258.TIPO_ADDIZIONALE = ''R'' AND P258.TIPO_VERSAMENTO = ''S''' || chr(10) || 'AND P442.COD_VOCE IN (''11270'')' || chr(10) || 'AND P442.COD_VOCE_SPECIALE = ''BASE'' AND P442.TIPO_RECORD = ''M''' || chr(10) || 'UNION ALL' || chr(10) || '-- Modello 730' || chr(10) || 'SELECT P441.PROGRESSIVO, TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE_CED, TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') ANNO_CED,' || chr(10) || 'SUBSTR(P200.COD_CAUSALEIRPEF,4) COD_TRIBUTO, P264.COD_ENTE,' || chr(10) || 'TRIM(TO_CHAR(P260.ANNO + P260.ANNO_IMPOSTA)) ANNO_COMP,' || chr(10) || 'DECODE(P200.IMPORTO_COLONNA,''C'',0,''R'',P442.IMPORTO) RITENUTA,' || chr(10) || 'DECODE(P200.IMPORTO_COLONNA,''C'',P442.IMPORTO,''R'',0) SCOMPUTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P200_VOCI P200,' || chr(10) || '     P260_MOD730TIPOIMPORTI P260, P264_MOD730IMPORTI P264, T482_REGIONI T482' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') = :Anno AND P441.CHIUSO = ''S'' AND P441.TIPO_CEDOLINO <> ''RP''' || chr(10) || 'AND P442.TIPO_RECORD = ''M'' AND P200.ID_VOCE = P442.ID_VOCE AND' || chr(10) || '(' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE) OR' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE_INT_RATE AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE_INT_RATE) OR' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE_INT_RITARDO AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE_INT_RITARDO)' || chr(10) || ') AND' || chr(10) || 'TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'') = P260.ANNO AND P260.TIPO_ENTE = ''R'' AND' || chr(10) || 'P260.ANNO = P264.ANNO AND P260.COD_TIPOIMPORTO = P264.COD_TIPOIMPORTO AND' || chr(10) || 'P264.PROGRESSIVO = P441.PROGRESSIVO AND' || chr(10) || 'P264.COD_ENTE = T482.COD_REGIONE(+)' || chr(10) || ')' || chr(10) || 'GROUP BY MESE_CED, ANNO_CED, COD_TRIBUTO, COD_ENTE, ANNO_COMP' || chr(10) || 'HAVING (SUM(RITENUTA) <> 0 OR SUM(SCOMPUTO) <> 0)' || chr(10) || ') Q, P500_CUDSETUP P500' || chr(10) || 'WHERE Q.ANNO_CED = P500.ANNO' || chr(10) || 'ORDER BY ANNO_CED, MESE_CED, COD_ENTE, COD_TRIBUTO, ANNO_COMP', 
        'SELECT Q.*,' || chr(10) || '       DECODE(VERSATO,''0'','''',' || chr(10) || '                          DECODE(MESE_CED,''01'',P500.DATA_VERS_IRPEF01,''02'',P500.DATA_VERS_IRPEF02,''03'',P500.DATA_VERS_IRPEF03,' || chr(10) || '                                          ''04'',P500.DATA_VERS_IRPEF04,''05'',P500.DATA_VERS_IRPEF05,''06'',P500.DATA_VERS_IRPEF06,' || chr(10) || '                                          ''07'',P500.DATA_VERS_IRPEF07,''08'',P500.DATA_VERS_IRPEF08,''09'',P500.DATA_VERS_IRPEF09,' || chr(10) || '                                          ''10'',P500.DATA_VERS_IRPEF10,''11'',P500.DATA_VERS_IRPEF11,''12'',P500.DATA_VERS_IRPEF12))' || chr(10) || '       DATA_VERSAMENTO FROM' || chr(10) || '(' || chr(10) || '-- Query con dati finali tranne che data versamento' || chr(10) || 'SELECT MESE_CED, ANNO_CED, MESE_CED||ANNO_CED PERIODO_RIF,' || chr(10) || '       COD_TRIBUTO, COD_ENTE, ANNO_COMP,' || chr(10) || '       SUM(RITENUTA) RITENUTA, SUM(SCOMPUTO) SCOMPUTO, SUM(RITENUTA) - SUM(SCOMPUTO) VERSATO,' || chr(10) || '       DECODE(ANNO_COMP,:Anno,''S'','''') NOTE FROM' || chr(10) || '(' || chr(10) || '-- Query di dettaglio' || chr(10) || '-- Addizionali regionali saldo' || chr(10) || 'SELECT P441.PROGRESSIVO, TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE_CED, TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') ANNO_CED,' || chr(10) || '''381E'' COD_TRIBUTO, T482.COD_IRPEF COD_ENTE,' || chr(10) || 'TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'') ANNO_COMP,' || chr(10) || 'P442.IMPORTO RITENUTA, 0 SCOMPUTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P258_ADDIZIONALIIRPEF P258, T482_REGIONI T482' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO AND P441.PROGRESSIVO = P258.PROGRESSIVO AND T482.COD_REGIONE = P258.COD_ENTE' || chr(10) || 'AND TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') = :Anno AND P441.CHIUSO = ''S'' AND P441.TIPO_CEDOLINO <> ''RP''' || chr(10) || 'AND P258.ANNO = TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'')' || chr(10) || 'AND P258.TIPO_ADDIZIONALE = ''R'' AND P258.TIPO_VERSAMENTO = ''S''' || chr(10) || 'AND P442.COD_VOCE IN (''11270'')' || chr(10) || 'AND P442.COD_VOCE_SPECIALE = ''BASE'' AND P442.TIPO_RECORD = ''M''' || chr(10) || 'UNION ALL' || chr(10) || '-- Modello 730' || chr(10) || 'SELECT P441.PROGRESSIVO, TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE_CED, TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') ANNO_CED,' || chr(10) || 'SUBSTR(P200.COD_CAUSALEIRPEF,4) COD_TRIBUTO, P264.COD_ENTE,' || chr(10) || 'TRIM(TO_CHAR(P260.ANNO + P260.ANNO_IMPOSTA)) ANNO_COMP,' || chr(10) || 'DECODE(P200.IMPORTO_COLONNA,''C'',0,''R'',P442.IMPORTO) RITENUTA,' || chr(10) || 'DECODE(P200.IMPORTO_COLONNA,''C'',P442.IMPORTO,''R'',0) SCOMPUTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P200_VOCI P200,' || chr(10) || '     P260_MOD730TIPOIMPORTI P260, P264_MOD730IMPORTI P264, T482_REGIONI T482' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') = :Anno AND P441.CHIUSO = ''S'' AND P441.TIPO_CEDOLINO <> ''RP''' || chr(10) || 'AND P442.TIPO_RECORD = ''M'' AND P200.ID_VOCE = P442.ID_VOCE AND' || chr(10) || '(' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE) OR' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE_INT_RATE AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE_INT_RATE) OR' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE_INT_RITARDO AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE_INT_RITARDO)' || chr(10) || ') AND' || chr(10) || 'TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'') = P260.ANNO AND P260.TIPO_ENTE = ''R'' AND' || chr(10) || 'P260.ANNO = P264.ANNO AND P260.COD_TIPOIMPORTO = P264.COD_TIPOIMPORTO AND' || chr(10) || 'P264.PROGRESSIVO = P441.PROGRESSIVO AND' || chr(10) || 'P264.COD_ENTE = T482.COD_REGIONE(+)' || chr(10) || ')' || chr(10) || 'GROUP BY MESE_CED, ANNO_CED, COD_TRIBUTO, COD_ENTE, ANNO_COMP' || chr(10) || 'HAVING (SUM(RITENUTA) <> 0 OR SUM(SCOMPUTO) <> 0)' || chr(10) || ') Q, P500_CUDSETUP P500' || chr(10) || 'WHERE Q.ANNO_CED = P500.ANNO' || chr(10) || 'ORDER BY ANNO_CED, MESE_CED, COD_ENTE, COD_TRIBUTO, ANNO_COMP', 
        'N', null, 'N', '001', null);
insert into P602_770REGOLE (anno, parte, numero, tipo_record, sezione_file, formato_file, parte_cud, numero_cud, descrizione, numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, formato_annomese, numero_file, cod_arrotondamento_file)
values (2013, 'SX07', '001', 'F', 'SX', 'AN', null, null, 'Addizionale regionale/comunale - Ente impositore', 'N', null, null, 'S', 
        'SELECT * FROM' || chr(10) || '(' || chr(10) || 'SELECT COD_ENTE, SUM(VERS_ECCESSO) VERS_ECCESSO, SUM(AMM_SCOMPUTO) AMM_SCOMPUTO FROM' || chr(10) || '-- Query con dati finali addizionali regionali' || chr(10) || '(' || chr(10) || '-- Query per calcolare scomputi mensili' || chr(10) || 'SELECT MESE_CED, ANNO_CED, COD_ENTE,' || chr(10) || '       SUM(SCOMPUTO) VERS_ECCESSO, LEAST(SUM(SCOMPUTO),SUM(RITENUTA)) AMM_SCOMPUTO FROM' || chr(10) || '(' || chr(10) || '-- Query di dettaglio' || chr(10) || '-- Addizionali regionali saldo' || chr(10) || 'SELECT P441.PROGRESSIVO, TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE_CED, TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') ANNO_CED,' || chr(10) || '''381E'' COD_TRIBUTO, T482.COD_IRPEF COD_ENTE,' || chr(10) || 'TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'') ANNO_COMP,' || chr(10) || 'P442.IMPORTO RITENUTA, 0 SCOMPUTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P258_ADDIZIONALIIRPEF P258, T482_REGIONI T482' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO AND P441.PROGRESSIVO = P258.PROGRESSIVO AND T482.COD_REGIONE = P258.COD_ENTE' || chr(10) || 'AND TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') = :Anno AND P441.CHIUSO = ''S'' AND P441.TIPO_CEDOLINO <> ''RP''' || chr(10) || 'AND P258.ANNO = TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'')' || chr(10) || 'AND P258.TIPO_ADDIZIONALE = ''R'' AND P258.TIPO_VERSAMENTO = ''S''' || chr(10) || 'AND P442.COD_VOCE IN (''11270'')' || chr(10) || 'AND P442.COD_VOCE_SPECIALE = ''BASE'' AND P442.TIPO_RECORD = ''M''' || chr(10) || 'UNION ALL' || chr(10) || '-- Modello 730' || chr(10) || 'SELECT P441.PROGRESSIVO, TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE_CED, TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') ANNO_CED,' || chr(10) || 'SUBSTR(P200.COD_CAUSALEIRPEF,4) COD_TRIBUTO, P264.COD_ENTE,' || chr(10) || 'TRIM(TO_CHAR(P260.ANNO + P260.ANNO_IMPOSTA)) ANNO_COMP,' || chr(10) || 'DECODE(P200.IMPORTO_COLONNA,''C'',0,''R'',P442.IMPORTO) RITENUTA,' || chr(10) || 'DECODE(P200.IMPORTO_COLONNA,''C'',P442.IMPORTO,''R'',0) SCOMPUTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P200_VOCI P200,' || chr(10) || '     P260_MOD730TIPOIMPORTI P260, P264_MOD730IMPORTI P264, T482_REGIONI T482' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') = :Anno AND P441.CHIUSO = ''S'' AND P441.TIPO_CEDOLINO <> ''RP''' || chr(10) || 'AND P442.TIPO_RECORD = ''M'' AND P200.ID_VOCE = P442.ID_VOCE AND' || chr(10) || '(' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE) OR' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE_INT_RATE AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE_INT_RATE) OR' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE_INT_RITARDO AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE_INT_RITARDO)' || chr(10) || ') AND' || chr(10) || 'TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'') = P260.ANNO AND P260.TIPO_ENTE = ''R'' AND' || chr(10) || 'P260.ANNO = P264.ANNO AND P260.COD_TIPOIMPORTO = P264.COD_TIPOIMPORTO AND' || chr(10) || 'P264.PROGRESSIVO = P441.PROGRESSIVO AND' || chr(10) || 'P264.COD_ENTE = T482.COD_REGIONE(+)' || chr(10) || ')' || chr(10) || 'GROUP BY MESE_CED, ANNO_CED, COD_ENTE' || chr(10) || 'HAVING SUM(SCOMPUTO) <> 0' || chr(10) || ')' || chr(10) || 'GROUP BY COD_ENTE' || chr(10) || 'UNION ALL', 
        'SELECT * FROM' || chr(10) || '(' || chr(10) || 'SELECT COD_ENTE, SUM(VERS_ECCESSO) VERS_ECCESSO, SUM(AMM_SCOMPUTO) AMM_SCOMPUTO FROM' || chr(10) || '-- Query con dati finali addizionali regionali' || chr(10) || '(' || chr(10) || '-- Query per calcolare scomputi mensili' || chr(10) || 'SELECT MESE_CED, ANNO_CED, COD_ENTE,' || chr(10) || '       SUM(SCOMPUTO) VERS_ECCESSO, LEAST(SUM(SCOMPUTO),SUM(RITENUTA)) AMM_SCOMPUTO FROM' || chr(10) || '(' || chr(10) || '-- Query di dettaglio' || chr(10) || '-- Addizionali regionali saldo' || chr(10) || 'SELECT P441.PROGRESSIVO, TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE_CED, TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') ANNO_CED,' || chr(10) || '''381E'' COD_TRIBUTO, T482.COD_IRPEF COD_ENTE,' || chr(10) || 'TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'') ANNO_COMP,' || chr(10) || 'P442.IMPORTO RITENUTA, 0 SCOMPUTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P258_ADDIZIONALIIRPEF P258, T482_REGIONI T482' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO AND P441.PROGRESSIVO = P258.PROGRESSIVO AND T482.COD_REGIONE = P258.COD_ENTE' || chr(10) || 'AND TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') = :Anno AND P441.CHIUSO = ''S'' AND P441.TIPO_CEDOLINO <> ''RP''' || chr(10) || 'AND P258.ANNO = TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'')' || chr(10) || 'AND P258.TIPO_ADDIZIONALE = ''R'' AND P258.TIPO_VERSAMENTO = ''S''' || chr(10) || 'AND P442.COD_VOCE IN (''11270'')' || chr(10) || 'AND P442.COD_VOCE_SPECIALE = ''BASE'' AND P442.TIPO_RECORD = ''M''' || chr(10) || 'UNION ALL' || chr(10) || '-- Modello 730' || chr(10) || 'SELECT P441.PROGRESSIVO, TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE_CED, TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') ANNO_CED,' || chr(10) || 'SUBSTR(P200.COD_CAUSALEIRPEF,4) COD_TRIBUTO, P264.COD_ENTE,' || chr(10) || 'TRIM(TO_CHAR(P260.ANNO + P260.ANNO_IMPOSTA)) ANNO_COMP,' || chr(10) || 'DECODE(P200.IMPORTO_COLONNA,''C'',0,''R'',P442.IMPORTO) RITENUTA,' || chr(10) || 'DECODE(P200.IMPORTO_COLONNA,''C'',P442.IMPORTO,''R'',0) SCOMPUTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P200_VOCI P200,' || chr(10) || '     P260_MOD730TIPOIMPORTI P260, P264_MOD730IMPORTI P264, T482_REGIONI T482' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') = :Anno AND P441.CHIUSO = ''S'' AND P441.TIPO_CEDOLINO <> ''RP''' || chr(10) || 'AND P442.TIPO_RECORD = ''M'' AND P200.ID_VOCE = P442.ID_VOCE AND' || chr(10) || '(' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE) OR' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE_INT_RATE AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE_INT_RATE) OR' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE_INT_RITARDO AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE_INT_RITARDO)' || chr(10) || ') AND' || chr(10) || 'TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'') = P260.ANNO AND P260.TIPO_ENTE = ''R'' AND' || chr(10) || 'P260.ANNO = P264.ANNO AND P260.COD_TIPOIMPORTO = P264.COD_TIPOIMPORTO AND' || chr(10) || 'P264.PROGRESSIVO = P441.PROGRESSIVO AND' || chr(10) || 'P264.COD_ENTE = T482.COD_REGIONE(+)' || chr(10) || ')' || chr(10) || 'GROUP BY MESE_CED, ANNO_CED, COD_ENTE' || chr(10) || 'HAVING SUM(SCOMPUTO) <> 0' || chr(10) || ')' || chr(10) || 'GROUP BY COD_ENTE' || chr(10) || 'UNION ALL', 
        'N', null, 'N', '001', null);


  end if;
end;
/

insert into T480_COMUNI
select '016252','SANT''OMOBONO TERME','24038','BG','M333' from dual
where not exists
(select * from T480_COMUNI T where T.CODCATASTALE='M333');

update T480_COMUNI T480 set T480.CITTA='SANT''OMOBONO TERME (comune soppresso)' where T480.CODCATASTALE='I349';

-- Aggiunto campo NOTE su Addizionali IRPEF
alter table P042_ENTIIRPEF add NOTE varchar2(2000);
comment on column P042_ENTIIRPEF.NOTE is 'Note';

insert into T482_REGIONI
select '21_01','VENETO AGEVOLAZIONE','21','S' from DUAL
where not exists (select 'x' from T482_REGIONI T482 where T482.COD_REGIONE='21_01');
	
insert into T482_REGIONI
select '08_01','LAZIO AGEVOLAZIONE','08','S' from DUAL
where not exists (select 'x' from T482_REGIONI T482 where T482.COD_REGIONE='08_01');

insert into T482_REGIONI
select '02_01','BASILICATA AGEVOLAZIONE','02','S' from DUAL
where not exists (select 'x' from T482_REGIONI T482 where T482.COD_REGIONE='02_01');

-- Aggiunto campo BONUS_RIDUZ_CUNEO_FISC su P430_ANAGRAFICO
alter table P430_ANAGRAFICO add BONUS_RIDUZ_CUNEO_FISC varchar2(1) default 'S';
comment on column P430_ANAGRAFICO.BONUS_RIDUZ_CUNEO_FISC
  is 'Tipo riconoscimento bonus riduzione cuneo fiscale: S=Riconosciuto con conguaglio, Z=Riconosciuto senza conguaglio, N=Non riconosciuto';

-- Eliminazione V430 per forzare riaggiornamento da applicativo
declare
  C integer;
begin
  select COUNT(*) into C from P001_TABP430 where TABELLA = 'T030_ANAGRAFICO';
  if C > 0 then
    execute immediate 'drop view V430_STORICO';
  end if;  
end;
/

comment on column P430_ANAGRAFICO.REDDITO_DETRAZ_REDDITI_MIN
  is 'Reddito annuale complessivo per calcolo detrazioni per redditi minimi; (non utilizzato)';
comment on column P430_ANAGRAFICO.DETRAZ_PROGR_IMP
  is 'Calcolo detrazioni per mantenimento progressivita'' imposizione (non utilizzato)';
comment on column P430_ANAGRAFICO.REDDITO_DETRAZ_PROGR_IMP
  is 'Reddito annuale complessivo per calcolo deduzioni e detrazioni no-tax area; (non utilizzato)';
comment on column P430_ANAGRAFICO.COD_DEDUZIONEIRPEF
  is 'Codice deduzione IRPEF (non utilizzato)';
comment on column P430_ANAGRAFICO.cod_nazionalitaestere
  is 'Codice nazionalita'' estera (non utilizzato)';

drop table P430_APPOGGIO;
create table P430_APPOGGIO as select * from P430_ANAGRAFICO where PROGRESSIVO = -1;

-- Conversione BONUS dai mensili all'anagrafico stipendiale
declare
  cursor c1 is 
    select PROGRESSIVO, TRUNC(DATA_RETRIBUZIONE,'MM') DECORRENZA, DECODE(VALORE,'N','N','NOCONG','Z') VALORE 
      from P450_DATIMENSILI P450
     where P450.COD_CAMPO = 'BORCF'
       and P450.TIPO_RECORD = 'M';
  wDataDal date;
begin
  for t1 in c1 loop
    wDataDal:=t1.DECORRENZA;
    Creazione_storico_Stipendi(t1.PROGRESSIVO,wDataDal,null);
    update P430_ANAGRAFICO P430
       set P430.BONUS_RIDUZ_CUNEO_FISC = t1.VALORE 
     where P430.PROGRESSIVO = t1.PROGRESSIVO
       and P430.DECORRENZA >= t1.DECORRENZA;
  end loop;
end;
/

delete from P450_DATIMENSILI P450 where P450.COD_CAMPO = 'BORCF';
delete from P452_DATIMENSILIDESC P452 where P452.COD_CAMPO = 'BORCF';

update P670_XMLREGOLE P670 set P670.NUMERO='D118' where P670.NUMERO='D095';
update P673_XMLDATIINDIVIDUALI P673 set P673.NUMERO='D118' where P673.NUMERO='D095';

---------------------------
-- INIZIO NUOVE REGOLE UNIEMENS per creazione nodo VarRetributive
---------------------------
declare
  i integer;
begin
  select COUNT(*) into i from P670_XMLREGOLE t where t.Nome_Flusso='UNIEMENS';
  if i > 0 then
     DELETE P670_XMLREGOLE t WHERE t.NOME_FLUSSO='UNIEMENS' AND t.NUMERO IN ('D115','D450','D455','D460','D465');

insert into P670_XMLREGOLE (nome_flusso, decorrenza, numero, elemento, descrizione, numero_padre, formato_file, numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, attributo, tipo_importo, dato_riepilogativo, decorrenza_fine)
values ('UNIEMENS', to_date('01-04-2010', 'dd-mm-yyyy'), 'D115', 'VarRetributive', 'Informazioni relative alla diminuzione dell''imponibile di competenza di periodi pregressi', 'D080', null, 'N', null, null, 'N', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
insert into P670_XMLREGOLE (nome_flusso, decorrenza, numero, elemento, descrizione, numero_padre, formato_file, numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, attributo, tipo_importo, dato_riepilogativo, decorrenza_fine)
values ('UNIEMENS', to_date('01-04-2010', 'dd-mm-yyyy'), 'D450', 'AnnoMeseVarRetr', 'Anno e mese della denuncia originaria sulla quale deve agire la variabile retributiva', 'D115', 'D7', 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
insert into P670_XMLREGOLE (nome_flusso, decorrenza, numero, elemento, descrizione, numero_padre, formato_file, numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, attributo, tipo_importo, dato_riepilogativo, decorrenza_fine)
values ('UNIEMENS', to_date('01-04-2010', 'dd-mm-yyyy'), 'D455', 'CausaleVarRetr', 'Motivazione all''origine della variabile retributiva', 'D115', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
insert into P670_XMLREGOLE (nome_flusso, decorrenza, numero, elemento, descrizione, numero_padre, formato_file, numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, attributo, tipo_importo, dato_riepilogativo, decorrenza_fine)
values ('UNIEMENS', to_date('01-04-2010', 'dd-mm-yyyy'), 'D460', 'ImponibileVarRetr', 'Quota di retribuzione che comporta la diminuzione dell''imponibile dell''anno di riferimento', 'D115', null, 'S', 'P1000', null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
insert into P670_XMLREGOLE (nome_flusso, decorrenza, numero, elemento, descrizione, numero_padre, formato_file, numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, attributo, tipo_importo, dato_riepilogativo, decorrenza_fine)
values ('UNIEMENS', to_date('01-04-2010', 'dd-mm-yyyy'), 'D465', 'ContributoVarRetr', 'Importo della contribuzione riferita alla quota di imponibile oggetto della variabile', 'D115', null, 'S', 'P1', null, 'S', null, null, 'N', null, null, 'C', 'N', to_date('31-12-3999', 'dd-mm-yyyy'));

  end if;
end;
/
