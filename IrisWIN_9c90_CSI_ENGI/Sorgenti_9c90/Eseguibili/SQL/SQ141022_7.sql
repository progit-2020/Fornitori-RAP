update P002_TABANNUALI P002 set P002.DESCRIZIONE='Categorie particolari CU-770' where P002.COD_TABANNUALE='770CATPART';
update P002_TABANNUALI P002 set P002.DESCRIZIONE='Causali pagamenti sezione lavoratori autonomi CU-770' where P002.COD_TABANNUALE='770CAUSPAG';
update P002_TABANNUALI P002 set P002.DESCRIZIONE='Qualifiche (ulteriori categorie) sezione Inail CU-770' where P002.COD_TABANNUALE='770QUAUCAT';

declare
  i integer;
begin
    select COUNT(*) into i from P250_VOCIAGGIUNTIVE t where T.COD_CONTRATTO ='EDP' AND T.NOME_VOCEAGGIUNTIVA = 'INCARICO';
    if i > 0 then

      update i501incarico t
      set t.descrizione=replace(t.descrizione,'dec. 2010-2014','dec. 2010-2015')
      where t.descrizione like '%dec. 2010-2014%';

      update p252_vociaggiuntiveimporti t
      set t.descrizione=replace(t.descrizione,'dec. 2010-2014','dec. 2010-2015')
      where t.cod_contratto='EDP' and t.nome_voceaggiuntiva='INCARICO'
      and t.descrizione like '%dec. 2010-2014%';

    end if;
end;
/

update P026_FONDIPREVCOMPL P026 set P026.DESCRIZIONE='Perseo-Sirio dipendenti optanti (ex TFS) - Garantito' where P026.COD_FPC='21641OPT';
update P026_FONDIPREVCOMPL P026 set P026.DESCRIZIONE='Perseo-Sirio dipendenti TFR - Garantito' where P026.COD_FPC='21641TFR';

alter table P507_CUDPARTIC add parte VARCHAR2(5);
alter table P507_CUDPARTIC add numero VARCHAR2(4);
alter table P507_CUDPARTIC add valore VARCHAR2(40);
comment on column P507_CUDPARTIC.azione
  is 'Azione: 1=Modello CU da non elaborare, 2=Dati lavoro autonomo da cumulare su matricola di appoggio, 3=Dati tassazione separata da cumulare su matricola di appoggio, 4=Impostazione valore fisso';
comment on column P507_CUDPARTIC.parte
  is 'Parte o sezione del CU con valore fisso da impostare';
comment on column P507_CUDPARTIC.numero
  is 'Numero del dato o codice interno del CU con valore fisso da impostare';
comment on column P507_CUDPARTIC.valore
  is 'Valore fisso del CU da impostare';

---------------------------
-- Inizio regola CU - 2015 Parte B Numero 121
---------------------------
declare
  i integer;
begin
  select COUNT(*) into i from P502_CUDREGOLE;
  if i > 0 then
     DELETE P502_CUDREGOLE t WHERE t.anno=2014 and t.parte='B' and t.numero='121';

insert into P502_CUDREGOLE (anno, parte, numero, descrizione, numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, tipo_record_file, codice_file, formato_speciale_file, codice_speciale_file, formato_file, valore_fisso_file)
values (2014, 'B', '121', 'Credito bonus Irpef - Bonus non erogato', 'S', 'P1', 'M=S,D=2,0=N', 'S', 
        'SELECT SUM(IMPORTO) DATO FROM' || chr(10) || '(' || chr(10) || '-- Inizio query per calcolo bonus spettante' || chr(10) || '(' || chr(10) || 'SELECT ROUND(' || chr(10) || '             DECODE(SIGN(REDDITO - 24000),-1,640,640 * TRUNC((26000 - REDDITO) / 2000,4)) -- Bonus annuo' || chr(10) || '             * GG_DETRAZIONI / 365' || chr(10) || '             ,2) IMPORTO' || chr(10) || 'FROM' || chr(10) || '(' || chr(10) || '-- Inizio query per calcolo reddito, ritenuta lorda, detrazioni e giorni lavoro dipendente' || chr(10) || 'SELECT SUM(REDDITO) REDDITO, SUM(RITENUTA_LORDA) RITENUTA_LORDA, SUM(DETRAZ_LAV_DIP) DETRAZ_LAV_DIP, SUM(GG_DETRAZIONI) GG_DETRAZIONI FROM' || chr(10) || '(' || chr(10) || 'SELECT COD_VOCE, DECODE(COD_VOCE,''10240'',IMPORTO,''10245'',-IMPORTO,0) REDDITO,' || chr(10) || '       DECODE(COD_VOCE,''11240'',IMPORTO,0) RITENUTA_LORDA,' || chr(10) || '       DECODE(COD_VOCE,''13012'',IMPORTO,0) DETRAZ_LAV_DIP,' || chr(10) || '       DECODE(COD_VOCE,''13012'',NVL(TO_NUMBER(QUANTITA,''9G999D99'',''nls_numeric_characters='''',.''''''),0),0) GG_DETRAZIONI       ' || chr(10) || 'FROM P442_CEDOLINOVOCI WHERE ID_CEDOLINO = :IdCedCongIRPEF AND' || chr(10) || ':TipoDipendente <> ''ER'' AND TO_CHAR(DATA_COMPETENZA_A,''YYYY'') = :Anno AND' || chr(10) || 'COD_VOCE IN (''10240'',''10245'',''13012'',''11240'') AND COD_VOCE_SPECIALE = ''CONG'' AND TIPO_RECORD = ''M''' || chr(10) || 'UNION ALL' || chr(10) || 'SELECT '''',(NVL(P430.REDDITO_DETRAZ_FIGLI_ALTRI,0) + NVL(P430.REDDITO_DETRAZ_LAVDIP,0)) REDDITO, 0, 0, 0' || chr(10) || 'FROM P430_ANAGRAFICO P430 WHERE P430.PROGRESSIVO = :Progressivo AND' || chr(10) || ':TipoDipendente <> ''ER'' AND TO_DATE(''3112''||:Anno,''ddmmyyyy'') BETWEEN P430.DECORRENZA AND P430.DECORRENZA_FINE' || chr(10) || ')' || chr(10) || '-- Fine query per calcolo reddito, ritenuta lorda, detrazioni e giorni lavoro dipendente' || chr(10) || ')' || chr(10) || '-- Verifica fascia di reddito per diritto al bonus' || chr(10) || 'WHERE REDDITO > 0 AND REDDITO < 26000' || chr(10) || '-- Verifica presenza di detrazioni lavoro dipendente con capienza nella ritenuta lorda' || chr(10) || 'AND DETRAZ_LAV_DIP > 0 AND DETRAZ_LAV_DIP < RITENUTA_LORDA' || chr(10) || ')' || chr(10) || '-- Fine query per calcolo bonus spettante' || chr(10) || 'UNION ALL' || chr(10) || '(' || chr(10) || '-- Inizio query per calcolo bonus erogato' || chr(10) || 'SELECT - SUM(P442.IMPORTO) IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442' || chr(10) || 'WHERE P442.ID_CEDOLINO = P441.ID_CEDOLINO AND CHIUSO = ''S'' ' || chr(10) || 'AND P441.PROGRESSIVO = :Progressivo AND TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'') = :Anno ' || chr(10) || 'AND P442.COD_VOCE||P442.COD_VOCE_SPECIALE IN (''13160BASE'',''13162CONG'')' || chr(10) || 'AND TIPO_RECORD = ''M''' || chr(10) || '-- Fine query per calcolo bonus erogato' || chr(10) || ')' || chr(10) || ')' || chr(10) || '-- Verifica presenza cedolino periodo Maggio-Dicembre 2014' || chr(10) || 'WHERE EXISTS' || chr(10) || '(' || chr(10) || 'SELECT ''X'' FROM P441_CEDOLINO P441 WHERE P441.PROGRESSIVO = :Progressivo AND P441.CHIUSO=''S''' || chr(10) || 'AND P441.DATA_CEDOLINO BETWEEN TO_DATE(''01052014'',''ddmmyyyy'') AND TO_DATE(''31122014'',''ddmmyyyy'')' || chr(10) || ')', 
        'SELECT SUM(IMPORTO) DATO FROM' || chr(10) || '(' || chr(10) || '-- Inizio query per calcolo bonus spettante' || chr(10) || '(' || chr(10) || 'SELECT ROUND(' || chr(10) || '             DECODE(SIGN(REDDITO - 24000),-1,640,640 * TRUNC((26000 - REDDITO) / 2000,4)) -- Bonus annuo' || chr(10) || '             * GG_DETRAZIONI / 365' || chr(10) || '             ,2) IMPORTO' || chr(10) || 'FROM' || chr(10) || '(' || chr(10) || '-- Inizio query per calcolo reddito, ritenuta lorda, detrazioni e giorni lavoro dipendente' || chr(10) || 'SELECT SUM(REDDITO) REDDITO, SUM(RITENUTA_LORDA) RITENUTA_LORDA, SUM(DETRAZ_LAV_DIP) DETRAZ_LAV_DIP, SUM(GG_DETRAZIONI) GG_DETRAZIONI FROM' || chr(10) || '(' || chr(10) || 'SELECT COD_VOCE, DECODE(COD_VOCE,''10240'',IMPORTO,''10245'',-IMPORTO,0) REDDITO,' || chr(10) || '       DECODE(COD_VOCE,''11240'',IMPORTO,0) RITENUTA_LORDA,' || chr(10) || '       DECODE(COD_VOCE,''13012'',IMPORTO,0) DETRAZ_LAV_DIP,' || chr(10) || '       DECODE(COD_VOCE,''13012'',NVL(TO_NUMBER(QUANTITA,''9G999D99'',''nls_numeric_characters='''',.''''''),0),0) GG_DETRAZIONI       ' || chr(10) || 'FROM P442_CEDOLINOVOCI WHERE ID_CEDOLINO = :IdCedCongIRPEF AND' || chr(10) || ':TipoDipendente <> ''ER'' AND TO_CHAR(DATA_COMPETENZA_A,''YYYY'') = :Anno AND' || chr(10) || 'COD_VOCE IN (''10240'',''10245'',''13012'',''11240'') AND COD_VOCE_SPECIALE = ''CONG'' AND TIPO_RECORD = ''M''' || chr(10) || 'UNION ALL' || chr(10) || 'SELECT '''',(NVL(P430.REDDITO_DETRAZ_FIGLI_ALTRI,0) + NVL(P430.REDDITO_DETRAZ_LAVDIP,0)) REDDITO, 0, 0, 0' || chr(10) || 'FROM P430_ANAGRAFICO P430 WHERE P430.PROGRESSIVO = :Progressivo AND' || chr(10) || ':TipoDipendente <> ''ER'' AND TO_DATE(''3112''||:Anno,''ddmmyyyy'') BETWEEN P430.DECORRENZA AND P430.DECORRENZA_FINE' || chr(10) || ')' || chr(10) || '-- Fine query per calcolo reddito, ritenuta lorda, detrazioni e giorni lavoro dipendente' || chr(10) || ')' || chr(10) || '-- Verifica fascia di reddito per diritto al bonus' || chr(10) || 'WHERE REDDITO > 0 AND REDDITO < 26000' || chr(10) || '-- Verifica presenza di detrazioni lavoro dipendente con capienza nella ritenuta lorda' || chr(10) || 'AND DETRAZ_LAV_DIP > 0 AND DETRAZ_LAV_DIP < RITENUTA_LORDA' || chr(10) || ')' || chr(10) || '-- Fine query per calcolo bonus spettante' || chr(10) || 'UNION ALL' || chr(10) || '(' || chr(10) || '-- Inizio query per calcolo bonus erogato' || chr(10) || 'SELECT - SUM(P442.IMPORTO) IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442' || chr(10) || 'WHERE P442.ID_CEDOLINO = P441.ID_CEDOLINO AND CHIUSO = ''S'' ' || chr(10) || 'AND P441.PROGRESSIVO = :Progressivo AND TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'') = :Anno ' || chr(10) || 'AND P442.COD_VOCE||P442.COD_VOCE_SPECIALE IN (''13160BASE'',''13162CONG'')' || chr(10) || 'AND TIPO_RECORD = ''M''' || chr(10) || '-- Fine query per calcolo bonus erogato' || chr(10) || ')' || chr(10) || ')' || chr(10) || '-- Verifica presenza cedolino periodo Maggio-Dicembre 2014' || chr(10) || 'WHERE EXISTS' || chr(10) || '(' || chr(10) || 'SELECT ''X'' FROM P441_CEDOLINO P441 WHERE P441.PROGRESSIVO = :Progressivo AND P441.CHIUSO=''S''' || chr(10) || 'AND P441.DATA_CEDOLINO BETWEEN TO_DATE(''01052014'',''ddmmyyyy'') AND TO_DATE(''31122014'',''ddmmyyyy'')' || chr(10) || ')', 
        'N', null, 'G', 'DB001121', 'N', null, 'VP', null);

  end if;
end;
/

update P502_CUDREGOLE P502 set P502.OMETTI_VUOTO='S'
where P502.ANNO=2014 AND P502.PARTE='A' AND P502.NUMERO NOT IN ('001','002');

---------------------------
-- Fine regola CU - 2015 Parte B Numero 121
---------------------------

-- Aggiornamento tipi servizio INPDAP
update P004_CODICITABANNUALI P004 set P004.DESCRIZIONE='Congedo parentale con retribuzione ridotta per maternita'' e per assistenza al bambino'
where P004.COD_TABANNUALE='IPTIPSERV' and P004.COD_CODICITABANNUALI='9';

update P004_CODICITABANNUALI P004 set P004.DESCRIZIONE='Congedo parentale senza retribuzione per assistenza al bambino - solo D.M.A. 2'
where P004.COD_TABANNUALE='IPTIPSERV' and P004.COD_CODICITABANNUALI='42';

insert into P004_CODICITABANNUALI
select P004.COD_TABANNUALE, '63', P004.ANNO, 
      'Congedo malattia bambino di eta'' inferiore ai tre anni con retribuzione ridotta o assente - ex art.47, comma 1, d. lgs. n.151/2001 - solo D.M.A. 2'
from P004_CODICITABANNUALI P004 where P004.COD_TABANNUALE='IPTIPSERV' and P004.COD_CODICITABANNUALI='9'
and not exists
(select 'x' from P004_CODICITABANNUALI P004A where P004A.COD_TABANNUALE=P004.COD_TABANNUALE
AND P004A.ANNO=P004.ANNO AND P004A.COD_CODICITABANNUALI='63');

insert into P004_CODICITABANNUALI
select P004.COD_TABANNUALE, '64', P004.ANNO, 
      'Congedo malattia bambino di eta'' superiore ai tre anni ed inferiore agli otto senza retribuzione (max 5 giorni all''anno per ciascun genitore) - ex art.47, comma 2, d. lgs. n.151/2001 - solo D.M.A. 2'
from P004_CODICITABANNUALI P004 where P004.COD_TABANNUALE='IPTIPSERV' and P004.COD_CODICITABANNUALI='9'
and not exists
(select 'x' from P004_CODICITABANNUALI P004A where P004A.COD_TABANNUALE=P004.COD_TABANNUALE
AND P004A.ANNO=P004.ANNO AND P004A.COD_CODICITABANNUALI='64');

update P200_VOCI P200 
set P200.DESCRIZIONE=replace(P200.DESCRIZIONE,' 3-8',''), P200.DESCRIZIONE_STAMPA=replace(P200.DESCRIZIONE_STAMPA,' 3-8','')
where P200.COD_CONTRATTO IN('EDP','EDPEL') and P200.COD_VOCE_SPECIALE='15030';

insert into P206_ASSENZEINPDAP
select COD_CONTRATTO, COD_VOCE, COD_VOCE_SPECIALE, TO_DATE('01012015','DDMMYYYY'), ELIMINA_SEZIONE, ABBATTE_GGUTILI, COD_TIPOSERVIZIO, COD_GESTASSIC_NONCOPERTE, COD_CAUSASOSPENSIONE, PERC_ASP_SINDACALE, PERC_RETRIBUZIONE, NOTE, DECORRENZA_FINE
from P206_ASSENZEINPDAP P206 
where P206.COD_CONTRATTO IN('EDP','EDPEL') and P206.COD_VOCE IN('15030','15032') and P206.COD_VOCE_SPECIALE='BASE'
and P206.DECORRENZA=TO_DATE('01102012','DDMMYYYY') AND P206.DECORRENZA_FINE=TO_DATE('31123999','DDMMYYYY');

update P206_ASSENZEINPDAP P206
set P206.DECORRENZA_FINE=TO_DATE('01012015','DDMMYYYY') -1 
where P206.COD_CONTRATTO IN('EDP','EDPEL') and P206.COD_VOCE IN('15030','15032') and P206.COD_VOCE_SPECIALE='BASE'
and P206.DECORRENZA=TO_DATE('01102012','DDMMYYYY') AND P206.DECORRENZA_FINE=TO_DATE('31123999','DDMMYYYY');

update P206_ASSENZEINPDAP P206
set P206.COD_TIPOSERVIZIO=decode(P206.COD_VOCE,'15030','64','15032','63') 
where P206.COD_CONTRATTO IN('EDP','EDPEL') and P206.COD_VOCE IN('15030','15032') and P206.COD_VOCE_SPECIALE='BASE'
and P206.DECORRENZA=TO_DATE('01012015','DDMMYYYY') AND P206.DECORRENZA_FINE=TO_DATE('31123999','DDMMYYYY');

-- *****************************************************************************
-- CREAZIONE VOCE 15031 Congedo parentale senza retr. ass. figli
-- *****************************************************************************

declare 
  i integer;
  ID_P200 integer;
  CodVoceModello varchar2(5);
  CodVoceCopia varchar2(5);
  DesVoceCopia varchar2(40);

begin
  CodVoceModello:='15030';
  CodVoceCopia:='15031';
  DesVoceCopia:='Congedo parentale senza retr. ass. figli';

select COUNT(*) into i from P441_CEDOLINO;
if i > 0 then
  select COUNT(*) into i from P200_VOCI t 
    where T.COD_CONTRATTO IN('EDP','EDPEL') and T.COD_VOCE=CodVoceModello and T.COD_VOCE_SPECIALE='BASE'
    and not exists
    (select 'X' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce=CodVoceCopia
       and v.cod_voce_speciale=t.cod_voce_speciale);
  if i > 0 then
  
-----
-- Creazione voce copiandola da 15030
-----

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopia, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario, importo_massimo from p200_voci T
WHERE T.COD_CONTRATTO IN('EDP','EDPEL') AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

-- Quote
INSERT INTO P205_QUOTE
SELECT COD_CONTRATTO, CodVoceCopia, COD_VOCE_SPECIALE_DA_QUOTARE, COD_VOCE_IN_QUOTA, COD_VOCE_SPECIALE_IN_QUOTA, DECORRENZA, ACCUMULO, ACCUMULO_RATEO, COD_VOCE_SPECIALE_DETTAGLIO, COD_VOCE_SPECIALE_DETTAGLIO13A  FROM P205_QUOTE T
WHERE T.COD_CONTRATTO IN('EDP','EDPEL') AND T.COD_VOCE_DA_QUOTARE=CodVoceModello AND T.COD_VOCE_SPECIALE_DA_QUOTARE='BASE';

-- Assenze INPDAP
INSERT INTO P206_ASSENZEINPDAP 
SELECT COD_CONTRATTO, CodVoceCopia, COD_VOCE_SPECIALE, DECORRENZA, ELIMINA_SEZIONE, ABBATTE_GGUTILI, '42', COD_GESTASSIC_NONCOPERTE, COD_CAUSASOSPENSIONE, PERC_ASP_SINDACALE, perc_retribuzione, 'D.M.A. 2', TO_DATE('31123999','DDMMYYYY') FROM P206_ASSENZEINPDAP T
WHERE T.COD_CONTRATTO IN('EDP','EDPEL') AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE ='BASE'
and T.DECORRENZA=TO_DATE('01012001','DDMMYYYY');

  end if;
end if;
end;
/

insert into T480_COMUNI
select '046037','SILLANO GIUNCUGNANO','55030','LU','M347' from dual
where not exists
(select * from T480_COMUNI T where T.CODCATASTALE='M347');

update T480_COMUNI T480 set T480.CITTA='GIUNCUGNANO (comune soppresso)' where T480.CODCATASTALE='E059';
update T480_COMUNI T480 set T480.CITTA='SILLANO (comune soppresso)' where T480.CODCATASTALE='I737';
