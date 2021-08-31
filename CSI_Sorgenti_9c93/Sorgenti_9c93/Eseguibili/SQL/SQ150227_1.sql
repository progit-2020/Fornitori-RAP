comment on column M010_PARAMETRICONTEGGIO.DATARIF_VOCEPAGHE
  is 'S=Data Scarico, M=Data Missione, C=Mese Missione: il mese di scarico paghe viene mantenuto uguale al mese missione';

--C90_W026ECCEDOLTREDEBITO
delete from MONDOEDP.I091_DATIENTE where AZIENDA = :AZIENDA and TIPO = 'C90_W026ECCEDOLTREDEBITO';
insert into MONDOEDP.I091_DATIENTE (AZIENDA,TIPO,DATO)
values (:AZIENDA,'C90_W026ECCEDOLTREDEBITO','N');

--C90_W026MMINDIETRODAL
delete from MONDOEDP.I091_DATIENTE where AZIENDA = :AZIENDA and TIPO = 'C90_W026MMINDIETRODAL';
insert into MONDOEDP.I091_DATIENTE (AZIENDA,TIPO,DATO)
select :AZIENDA,'C90_W026MMINDIETRODAL',decode(DATO,'N','12','1') 
from MONDOEDP.I091_DATIENTE where AZIENDA = :AZIENDA and TIPO = 'C90_W026ECCEDGG_TUTTA';

--C90_W026MMINDIETROAL
delete from MONDOEDP.I091_DATIENTE where AZIENDA = :AZIENDA and TIPO = 'C90_W026MMINDIETROAL';
insert into MONDOEDP.I091_DATIENTE (AZIENDA,TIPO,DATO)
values (:AZIENDA,'C90_W026MMINDIETROAL','1');

--C90_W026ARROTONDAMENTO
delete from MONDOEDP.I091_DATIENTE where AZIENDA = :AZIENDA and TIPO = 'C90_W026ARROTONDAMENTO';
insert into MONDOEDP.I091_DATIENTE (AZIENDA,TIPO,DATO)
select :AZIENDA,'C90_W026ARROTONDAMENTO',max(nvl(ARROT_RIEPGG,0))
from T275_CAUPRESENZE where TIPO_RICHIESTA_WEB in ('P','R')
and not exists (select 'x' from MONDOEDP.I091_DATIENTE where AZIENDA = :AZIENDA and TIPO = 'C90_W026ECCEDGG_TUTTA' and DATO = 'N')
having max(nvl(ARROT_RIEPGG,0)) is not null;
insert into MONDOEDP.I091_DATIENTE (AZIENDA,TIPO,DATO)
select :AZIENDA,'C90_W026ARROTONDAMENTO','0' from dual
where exists (select 'x' from MONDOEDP.I091_DATIENTE where AZIENDA = :AZIENDA and TIPO = 'C90_W026ECCEDGG_TUTTA' and DATO = 'N');

--C90_W026SPEZZONEMINIMO
delete from MONDOEDP.I091_DATIENTE where AZIENDA = :AZIENDA and TIPO = 'C90_W026SPEZZONEMINIMO';
insert into MONDOEDP.I091_DATIENTE (AZIENDA,TIPO,DATO)
select :AZIENDA,'C90_W026SPEZZONEMINIMO','15' from dual
where exists (select 'x' from MONDOEDP.I091_DATIENTE where AZIENDA = :AZIENDA and TIPO = 'C90_W026ECCEDGG_TUTTA' and DATO = 'N');
insert into MONDOEDP.I091_DATIENTE (AZIENDA,TIPO,DATO)
select :AZIENDA,'C90_W026SPEZZONEMINIMO',nvl(max(nvl(ARROT_RIEPGG,0)),0)
from T275_CAUPRESENZE where TIPO_RICHIESTA_WEB in ('P','R')
and not exists (select 'x' from MONDOEDP.I091_DATIENTE where AZIENDA = :AZIENDA and TIPO = 'C90_W026ECCEDGG_TUTTA' and DATO = 'N')
having max(nvl(ARROT_RIEPGG,0)) is not null;

alter table M140_RICHIESTE_MISSIONI add MISSIONE_RIAPERTA varchar2(1) default 'N';
comment on column M140_RICHIESTE_MISSIONI.MISSIONE_RIAPERTA is 'S = la missione è stata riaperta dall''operatore. N = la missione non è stata riaperta';

comment on column M150_RICHIESTE_RIMBORSI.STATO is 'null=Non autorizzato, A=Autorizzato, S=Pronto per l''importazione sulla M050, I=Importato sulla M050';
update M150_RICHIESTE_RIMBORSI set STATO = 'I' where STATO = 'S';
  
ALTER TABLE T750_PROGETTI_RENDICONTO ADD (CHIUSURA_DAL DATE, CHIUSURA_AL DATE);

comment on column T750_PROGETTI_RENDICONTO.CHIUSURA_DAL is 'Inizio chiusura del progetto';
comment on column T750_PROGETTI_RENDICONTO.CHIUSURA_AL is 'Fine chiusura del progetto';

ALTER TABLE T750_PROGETTI_RENDICONTO DROP COLUMN CAUASSPRES_ESCLUSE /*--NOLOG--*/;
ALTER TABLE T750_PROGETTI_RENDICONTO ADD CAUASSPRES_INCLUSE VARCHAR2(1000);

comment on column T750_PROGETTI_RENDICONTO.CAUASSPRES_INCLUSE is 'Causali di assenza e di presenza da rendicontare';

alter table m024_categ_dati_liberi modify min_fase_visibile default -1;
alter table m024_categ_dati_liberi modify max_fase_visibile default 9;

alter table m024_categ_dati_liberi modify min_fase_modifica default -1;
alter table m024_categ_dati_liberi modify max_fase_modifica default 0;

update m024_categ_dati_liberi set min_fase_visibile = nvl(min_fase_visibile,-1);
update m024_categ_dati_liberi set max_fase_visibile = nvl(max_fase_visibile,9);
update m024_categ_dati_liberi set min_fase_modifica = nvl(min_fase_modifica,-1);
update m024_categ_dati_liberi set max_fase_modifica = nvl(max_fase_modifica,0);

comment on column m024_categ_dati_liberi.min_fase_visibile is 'Fase a partire dalla quale la categoria di dati liberi è visibile. -1=visibile in inserimento richiesta, 0=visibile in richiesta esistente, >0=fasi associate ai livelli di autorizzazione';
comment on column m024_categ_dati_liberi.max_fase_visibile is 'Ultima fase in cui la categoria di dati liberi è visibile. -1=visibile in inserimento richiesta, 0=visibile in richiesta esistente, >0=fasi associate ai livelli di autorizzazione';
comment on column m024_categ_dati_liberi.min_fase_modifica is 'Fase a partire dalla quale la categoria di dati liberi è modificabile. -1=visibile in inserimento richiesta, 0=visibile in richiesta esistente, >0=fasi associate ai livelli di autorizzazione';
comment on column m024_categ_dati_liberi.max_fase_modifica is 'Ultima fase in cui la categoria di dati liberi è modificabile. -1=visibile in inserimento richiesta, 0=visibile in richiesta esistente, >0=fasi associate ai livelli di autorizzazione';
comment on column mondoedp.i096_livelli_iter_aut.fase is 'Numero indicante la fase applicativa a cui corrisponde il livello. Significativo solo per gli Iter delle Missioni e dello Straordinario mensile';

comment on column P200_VOCI.cod_causaleirpef
  is 'Tributo IRPEF F24 EP. Richiesto solo se la voce prevede importi';
  
alter table P200_VOCI add cod_causaleirpef_ord VARCHAR2(10);
comment on column P200_VOCI.cod_causaleirpef_ord
  is 'Tributo IRPEF F24 Ordinario. Richiesto solo se la voce prevede importi';  

alter table P200_VOCI
  add constraint P200_FK2_P080 foreign key (COD_CAUSALEIRPEF_ORD)
  references P080_CAUSALIIRPEF (COD_CAUSALEIRPEF);
  
update P200_VOCI P200 set P200.COD_CAUSALEIRPEF_ORD='';

delete P080_CAUSALIIRPEF P080 where P080.COD_CAUSALEIRPEF like 'F24ORD%';

insert into P080_CAUSALIIRPEF (cod_causaleirpef, descrizione)
values ('F24ORD1001', 'Ritenute su retribuzioni pensioni trasferte mensilita'' aggiuntive e relativo conguaglio');
insert into P080_CAUSALIIRPEF (cod_causaleirpef, descrizione)
values ('F24ORD1627', 'Eccedenza di versamenti di ritenute da lavoro dipendente e assimilati - art. 15, c. 1, lett. b) D.Lgs. n. 175/2014');
insert into P080_CAUSALIIRPEF (cod_causaleirpef, descrizione)
values ('F24ORD1631', 'Somme a titolo di imposte erariali rimborsate dal sostituto d''imposta a seguito di assistenza fiscale - art. 15, comma 1, lett. a), D.Lgs. n. 175/2014');
insert into P080_CAUSALIIRPEF (cod_causaleirpef, descrizione)
values ('F24ORD1632', 'Credito per famiglie numerose riconosciuto dal sostituto d''imposta di cui all''art. 12, c. 3, del TUIR');
insert into P080_CAUSALIIRPEF (cod_causaleirpef, descrizione)
values ('F24ORD1655', 'Recupero da parte dei sostituti d''imposta delle somme erogate ai sensi dell''articolo 1 del decreto-legge 24 aprile 2014, n. 66');
insert into P080_CAUSALIIRPEF (cod_causaleirpef, descrizione)
values ('F24ORD1669', 'Eccedenza di versamenti di addizionale regionale all''IRPEF trattenuta dal sostituto d''imposta - art. 15, c. 1, lett. b) D.Lgs. n. 175/2014');
insert into P080_CAUSALIIRPEF (cod_causaleirpef, descrizione)
values ('F24ORD1671', 'Eccedenza di versamenti di addizionale comunale all''IRPEF trattenuta dal sostituto d''imposta - art. 15, c. 1, lett. b) D.Lgs. n. 175/2014');
insert into P080_CAUSALIIRPEF (cod_causaleirpef, descrizione)
values ('F24ORD3796', 'Somme a titolo di addizionale regionale all''IRPEF rimborsate dal sostituto d''imposta a seguito di assistenza fiscale - art. 15, comma 1, lett. a), D.Lgs. n. 175/2014');
insert into P080_CAUSALIIRPEF (cod_causaleirpef, descrizione)
values ('F24ORD3797', 'Somme a titolo di addizionale comunale all''IRPEF rimborsate dal sostituto d''imposta a seguito di assistenza fiscale - art. 15, comma 1, lett. a), D.Lgs. n. 175/2014');

update P200_VOCI P200 set P200.COD_CAUSALEIRPEF_ORD='F24ORD1627'
where P200.COD_VOCE||P200.COD_VOCE_SPECIALE IN('11210BASE','11210CONG');

update P200_VOCI P200 set P200.COD_CAUSALEIRPEF_ORD='F24ORD1631'
where P200.COD_VOCE||P200.COD_VOCE_SPECIALE IN('11905BASE','11906BASE','11907BASE','11908BASE','11922BASE','11925BASE','11926BASE','11927BASE','11928BASE','11929BASE');

update P200_VOCI P200 set P200.COD_CAUSALEIRPEF_ORD='F24ORD1632'
where P200.COD_VOCE||P200.COD_VOCE_SPECIALE IN('13151BASE');

update P200_VOCI P200 set P200.COD_CAUSALEIRPEF_ORD='F24ORD1655'
where P200.COD_VOCE||P200.COD_VOCE_SPECIALE IN('13160BASE','13162CONG');

update P200_VOCI P200 set P200.COD_CAUSALEIRPEF_ORD='F24ORD1669'
where P200.COD_VOCE||P200.COD_VOCE_SPECIALE IN('11270BASE');

update P200_VOCI P200 set P200.COD_CAUSALEIRPEF_ORD='F24ORD1671'
where P200.COD_VOCE||P200.COD_VOCE_SPECIALE IN('11250BASE','11255BASE');

update P200_VOCI P200 set P200.COD_CAUSALEIRPEF_ORD='F24ORD3796'
where P200.COD_VOCE||P200.COD_VOCE_SPECIALE IN('11910BASE','11911BASE','11923BASE','11924BASE');

update P200_VOCI P200 set P200.COD_CAUSALEIRPEF_ORD='F24ORD3797'
where P200.COD_VOCE||P200.COD_VOCE_SPECIALE IN('11912BASE','11913BASE','11920BASE','11921BASE');

-- INIZIO creazione voce 13151 CONG (Credito agg. riconos.fam.num. mese cong.) 

declare
  i integer;
  ID_P200 integer;
  CodVoceModello varchar2(5);
  CodVoceCopia varchar2(5);
  DesVoceCopia varchar2(40);
  DesVoceCopiaSt varchar2(40);

  cursor C1 is  
  select T.COD_CONTRATTO from P200_VOCI T where T.COD_VOCE='13151' and T.COD_VOCE_SPECIALE='BASE'
  and not exists
  (select 'X' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce=t.cod_voce
     and v.cod_voce_speciale='CONG');

begin
  CodVoceModello:='13151';
  CodVoceCopia:='13151';
  DesVoceCopia:='Credito agg. riconos.fam.num. mese cong.';
  DesVoceCopiaSt:='Credito agg. riconos.fam.num. mese cong.';

  select COUNT(*) into i from P441_CEDOLINO;
  if i > 0 then

    for T1 in C1 loop
      select P200_ID_VOCE.NEXTVAL into ID_P200 from DUAL;

      insert into p200_voci
      select cod_contratto, CodVoceCopia, 'CONG', decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' C', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, 'N', stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario, importo_massimo, cod_causaleirpef_ord from p200_voci T
      WHERE T.COD_CONTRATTO=T1.cod_contratto AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

    end loop;

  end if;
end;
/

-- FINE creazione voce 13151 CONG (Credito agg. riconos.fam.num. mese cong.) 

delete P660_FLUSSIREGOLE P660 where P660.NOME_FLUSSO='F24ORD';

insert into P660_FLUSSIREGOLE (nome_flusso, decorrenza, parte, numero, descrizione, tipo_record, sezione_file, numero_file, formato_file, lunghezza_file, formato_annomese, numerico, cod_arrotondamento, formato, ometti_vuoto, tipo_dato, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, fl_numero_tredicesima, fl_numero_arrcorr, fl_numero_arrprec, nome_dato, codici_causali, fl_numero_tredprec)
values ('F24ORD', to_date('01-01-2008', 'dd-mm-yyyy'), 'E', '001', 'IRPEF prima parte', null, null, null, null, null, 'N', 'N', null, null, 'S', 'R', 'SELECT * FROM' || chr(10) || '(' || chr(10) || '-- Inizio query per ordinamento su importo decrescente' || chr(10) || 'SELECT TIPO_RIGA, COD_TRIBUTO, COD_ENTE, MESE, ANNO, COD_VOCE, COD_VOCE_SPECIALE, DESCRIZIONE, SUM(IMPORTO_CREDITO) IMPORTO_CREDITO FROM' || chr(10) || '(' || chr(10) || '-- Credito riconosciuto per famiglie numerose' || chr(10) || 'SELECT P441.PROGRESSIVO, ''F'' TIPO_RIGA,' || chr(10) || 'P200.COD_VOCE, P200.COD_VOCE_SPECIALE, P200.DESCRIZIONE,' || chr(10) || 'SUBSTR(P200.COD_CAUSALEIRPEF_ORD,7,4) COD_TRIBUTO,' || chr(10) || ''''' COD_ENTE, ''0000'' MESE,' || chr(10) || 'TO_NUMBER(TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'')) ANNO, P442.IMPORTO IMPORTO_CREDITO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P200_VOCI P200' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini) AND P441.TIPO_CEDOLINO <> ''RP''' || chr(10) || 'AND P442.COD_VOCE||P442.COD_VOCE_SPECIALE IN (''13151BASE'',''13151CONG'')' || chr(10) || 'AND P442.TIPO_RECORD = ''M'' AND P200.ID_VOCE = P442.ID_VOCE' || chr(10) || 'UNION ALL', 'SELECT * FROM' || chr(10) || '(' || chr(10) || '-- Inizio query per ordinamento su importo decrescente' || chr(10) || 'SELECT TIPO_RIGA, COD_TRIBUTO, COD_ENTE, MESE, ANNO, COD_VOCE, COD_VOCE_SPECIALE, DESCRIZIONE, SUM(IMPORTO_CREDITO) IMPORTO_CREDITO FROM' || chr(10) || '(' || chr(10) || '-- Credito riconosciuto per famiglie numerose' || chr(10) || 'SELECT P441.PROGRESSIVO, ''F'' TIPO_RIGA,' || chr(10) || 'P200.COD_VOCE, P200.COD_VOCE_SPECIALE, P200.DESCRIZIONE,' || chr(10) || 'SUBSTR(P200.COD_CAUSALEIRPEF_ORD,7,4) COD_TRIBUTO,' || chr(10) || ''''' COD_ENTE, ''0000'' MESE,' || chr(10) || 'TO_NUMBER(TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'')) ANNO, P442.IMPORTO IMPORTO_CREDITO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P200_VOCI P200' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini) AND P441.TIPO_CEDOLINO <> ''RP''' || chr(10) || 'AND P442.COD_VOCE||P442.COD_VOCE_SPECIALE IN (''13151BASE'',''13151CONG'')' || chr(10) || 'AND P442.TIPO_RECORD = ''M'' AND P200.ID_VOCE = P442.ID_VOCE' || chr(10) || 'UNION ALL', 
        'N', null, null, null, null, null, null, null);
insert into P660_FLUSSIREGOLE (nome_flusso, decorrenza, parte, numero, descrizione, tipo_record, sezione_file, numero_file, formato_file, lunghezza_file, formato_annomese, numerico, cod_arrotondamento, formato, ometti_vuoto, tipo_dato, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, fl_numero_tredicesima, fl_numero_arrcorr, fl_numero_arrprec, nome_dato, codici_causali, fl_numero_tredprec)
values ('F24ORD', to_date('01-01-2008', 'dd-mm-yyyy'), 'E', '002', 'IRPEF seconda parte', null, null, null, null, null, 'N', 'N', null, null, 'S', 'R', 
        '-- Bonus per la riduzione del cuneo fiscale' || chr(10) || 'SELECT P441.PROGRESSIVO, ''F'' TIPO_RIGA,' || chr(10) || 'P200.COD_VOCE, P200.COD_VOCE_SPECIALE, P200.DESCRIZIONE,' || chr(10) || 'SUBSTR(P200.COD_CAUSALEIRPEF_ORD,7,4) COD_TRIBUTO,' || chr(10) || ''''' COD_ENTE, ''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE,' || chr(10) || 'TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'')) ANNO, P442.IMPORTO IMPORTO_CREDITO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P200_VOCI P200' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini) AND P441.TIPO_CEDOLINO <> ''RP''' || chr(10) || 'AND P442.COD_VOCE||P442.COD_VOCE_SPECIALE IN (''13160BASE'',''13162CONG'')' || chr(10) || 'AND P442.TIPO_RECORD = ''M'' AND P200.ID_VOCE = P442.ID_VOCE' || chr(10) || 'UNION ALL' || chr(10) || '-- Rimborsi da modello 730' || chr(10) || 'SELECT P441.PROGRESSIVO, DECODE(P260.TIPO_ENTE,''N'',''F'',''R'',''R'',''C'',''S'') TIPO_RIGA,' || chr(10) || 'P200.COD_VOCE, P200.COD_VOCE_SPECIALE, P200.DESCRIZIONE,' || chr(10) || 'SUBSTR(P200.COD_CAUSALEIRPEF_ORD,7,4) COD_TRIBUTO,' || chr(10) || 'P264.COD_ENTE, ''0000'' MESE,' || chr(10) || 'P260.ANNO - 1 ANNO, P442.IMPORTO IMPORTO_CREDITO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P200_VOCI P200,' || chr(10) || '     P260_MOD730TIPOIMPORTI P260, P264_MOD730IMPORTI P264,' || chr(10) || '     T480_COMUNI T480, T482_REGIONI T482' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini) AND P441.TIPO_CEDOLINO <> ''RP''' || chr(10) || 'AND P442.TIPO_RECORD = ''M'' AND P200.ID_VOCE = P442.ID_VOCE AND P200.IMPORTO_COLONNA=''C'' AND' || chr(10) || '(' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE) OR' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE_INT_RATE AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE_INT_RATE) OR' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE_INT_RITARDO AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE_INT_RITARDO)' || chr(10) || ') AND' || chr(10) || 'TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'') = P260.ANNO AND' || chr(10) || 'P260.ANNO = P264.ANNO AND P260.COD_TIPOIMPORTO = P264.COD_TIPOIMPORTO AND' || chr(10) || 'P264.PROGRESSIVO = P441.PROGRESSIVO AND' || chr(10) || 'P264.COD_ENTE = T480.CODCATASTALE(+) AND P264.COD_ENTE = T482.COD_REGIONE(+)' || chr(10) || ')' || chr(10) || 'WHERE PROGRESSIVO IN (SELECT PROGRESSIVO FROM :C700SelAnagrafe)' || chr(10) || 'GROUP BY TIPO_RIGA, COD_TRIBUTO, COD_ENTE, MESE, ANNO, COD_VOCE, COD_VOCE_SPECIALE, DESCRIZIONE' || chr(10) || 'HAVING SUM(IMPORTO_CREDITO) <> 0' || chr(10) || '-- Fine query per ordinamento su importo decrescente' || chr(10) || ')' || chr(10) || 'ORDER BY TIPO_RIGA, IMPORTO_CREDITO DESC, COD_ENTE, COD_TRIBUTO, ANNO, COD_VOCE, COD_VOCE_SPECIALE, DESCRIZIONE' || chr(10) || '', 
        '-- Bonus per la riduzione del cuneo fiscale' || chr(10) || 'SELECT P441.PROGRESSIVO, ''F'' TIPO_RIGA,' || chr(10) || 'P200.COD_VOCE, P200.COD_VOCE_SPECIALE, P200.DESCRIZIONE,' || chr(10) || 'SUBSTR(P200.COD_CAUSALEIRPEF_ORD,7,4) COD_TRIBUTO,' || chr(10) || ''''' COD_ENTE, ''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE,' || chr(10) || 'TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'')) ANNO, P442.IMPORTO IMPORTO_CREDITO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P200_VOCI P200' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini) AND P441.TIPO_CEDOLINO <> ''RP''' || chr(10) || 'AND P442.COD_VOCE||P442.COD_VOCE_SPECIALE IN (''13160BASE'',''13162CONG'')' || chr(10) || 'AND P442.TIPO_RECORD = ''M'' AND P200.ID_VOCE = P442.ID_VOCE' || chr(10) || 'UNION ALL' || chr(10) || '-- Rimborsi da modello 730' || chr(10) || 'SELECT P441.PROGRESSIVO, DECODE(P260.TIPO_ENTE,''N'',''F'',''R'',''R'',''C'',''S'') TIPO_RIGA,' || chr(10) || 'P200.COD_VOCE, P200.COD_VOCE_SPECIALE, P200.DESCRIZIONE,' || chr(10) || 'SUBSTR(P200.COD_CAUSALEIRPEF_ORD,7,4) COD_TRIBUTO,' || chr(10) || 'P264.COD_ENTE, ''0000'' MESE,' || chr(10) || 'P260.ANNO - 1 ANNO, P442.IMPORTO IMPORTO_CREDITO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P200_VOCI P200,' || chr(10) || '     P260_MOD730TIPOIMPORTI P260, P264_MOD730IMPORTI P264,' || chr(10) || '     T480_COMUNI T480, T482_REGIONI T482' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini) AND P441.TIPO_CEDOLINO <> ''RP''' || chr(10) || 'AND P442.TIPO_RECORD = ''M'' AND P200.ID_VOCE = P442.ID_VOCE AND P200.IMPORTO_COLONNA=''C'' AND' || chr(10) || '(' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE) OR' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE_INT_RATE AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE_INT_RATE) OR' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE_INT_RITARDO AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE_INT_RITARDO)' || chr(10) || ') AND' || chr(10) || 'TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'') = P260.ANNO AND' || chr(10) || 'P260.ANNO = P264.ANNO AND P260.COD_TIPOIMPORTO = P264.COD_TIPOIMPORTO AND' || chr(10) || 'P264.PROGRESSIVO = P441.PROGRESSIVO AND' || chr(10) || 'P264.COD_ENTE = T480.CODCATASTALE(+) AND P264.COD_ENTE = T482.COD_REGIONE(+)' || chr(10) || ')' || chr(10) || 'WHERE PROGRESSIVO IN (SELECT PROGRESSIVO FROM :C700SelAnagrafe)' || chr(10) || 'GROUP BY TIPO_RIGA, COD_TRIBUTO, COD_ENTE, MESE, ANNO, COD_VOCE, COD_VOCE_SPECIALE, DESCRIZIONE' || chr(10) || 'HAVING SUM(IMPORTO_CREDITO) <> 0' || chr(10) || '-- Fine query per ordinamento su importo decrescente' || chr(10) || ')' || chr(10) || 'ORDER BY TIPO_RIGA, IMPORTO_CREDITO DESC, COD_ENTE, COD_TRIBUTO, ANNO, COD_VOCE, COD_VOCE_SPECIALE, DESCRIZIONE' || chr(10) || '', 
        'N', null, null, null, null, null, null, null);
insert into P660_FLUSSIREGOLE (nome_flusso, decorrenza, parte, numero, descrizione, tipo_record, sezione_file, numero_file, formato_file, lunghezza_file, formato_annomese, numerico, cod_arrotondamento, formato, ometti_vuoto, tipo_dato, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, fl_numero_tredicesima, fl_numero_arrcorr, fl_numero_arrprec, nome_dato, codici_causali, fl_numero_tredprec)
values ('F24ORD', to_date('01-01-2008', 'dd-mm-yyyy'), 'E1', '001', 'IRPEF prima parte con dati individuali', null, null, null, null, null, 'N', 'N', null, null, 'S', 'R', 'SELECT T030.MATRICOLA, T030.COGNOME, T030.NOME, TIPO_RIGA, COD_VOCE, COD_VOCE_SPECIALE, DESCRIZIONE,' || chr(10) || 'COD_TRIBUTO, COD_ENTE, MESE, ANNO, IMPORTO_CREDITO' || chr(10) || 'FROM' || chr(10) || '(' || chr(10) || '-- Credito riconosciuto per famiglie numerose' || chr(10) || 'SELECT P441.PROGRESSIVO, ''F'' TIPO_RIGA,' || chr(10) || 'P200.COD_VOCE, P200.COD_VOCE_SPECIALE, P200.DESCRIZIONE,' || chr(10) || 'SUBSTR(P200.COD_CAUSALEIRPEF_ORD,7,4) COD_TRIBUTO,' || chr(10) || ''''' COD_ENTE, ''0000'' MESE,' || chr(10) || 'TO_NUMBER(TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'')) ANNO, P442.IMPORTO IMPORTO_CREDITO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P200_VOCI P200' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini) AND P441.TIPO_CEDOLINO <> ''RP''' || chr(10) || 'AND P442.COD_VOCE||P442.COD_VOCE_SPECIALE IN (''13151BASE'',''13151CONG'')' || chr(10) || 'AND P442.TIPO_RECORD = ''M'' AND P200.ID_VOCE = P442.ID_VOCE' || chr(10) || 'UNION ALL', 'SELECT T030.MATRICOLA, T030.COGNOME, T030.NOME, TIPO_RIGA, COD_VOCE, COD_VOCE_SPECIALE, DESCRIZIONE,' || chr(10) || 'COD_TRIBUTO, COD_ENTE, MESE, ANNO, IMPORTO_CREDITO' || chr(10) || 'FROM' || chr(10) || '(' || chr(10) || '-- Credito riconosciuto per famiglie numerose' || chr(10) || 'SELECT P441.PROGRESSIVO, ''F'' TIPO_RIGA,' || chr(10) || 'P200.COD_VOCE, P200.COD_VOCE_SPECIALE, P200.DESCRIZIONE,' || chr(10) || 'SUBSTR(P200.COD_CAUSALEIRPEF_ORD,7,4) COD_TRIBUTO,' || chr(10) || ''''' COD_ENTE, ''0000'' MESE,' || chr(10) || 'TO_NUMBER(TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'')) ANNO, P442.IMPORTO IMPORTO_CREDITO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P200_VOCI P200' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini) AND P441.TIPO_CEDOLINO <> ''RP''' || chr(10) || 'AND P442.COD_VOCE||P442.COD_VOCE_SPECIALE IN (''13151BASE'',''13151CONG'')' || chr(10) || 'AND P442.TIPO_RECORD = ''M'' AND P200.ID_VOCE = P442.ID_VOCE' || chr(10) || 'UNION ALL', 'N', null, null, null, null, null, null, null);
insert into P660_FLUSSIREGOLE (nome_flusso, decorrenza, parte, numero, descrizione, tipo_record, sezione_file, numero_file, formato_file, lunghezza_file, formato_annomese, numerico, cod_arrotondamento, formato, ometti_vuoto, tipo_dato, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, fl_numero_tredicesima, fl_numero_arrcorr, fl_numero_arrprec, nome_dato, codici_causali, fl_numero_tredprec)
values ('F24ORD', to_date('01-01-2008', 'dd-mm-yyyy'), 'E1', '002', 'IRPEF seconda parte con dati individuali', null, null, null, null, null, 'N', 'N', null, null, 'S', 'R', 
        '-- Bonus per la riduzione del cuneo fiscale' || chr(10) || 'SELECT P441.PROGRESSIVO, ''F'' TIPO_RIGA,' || chr(10) || 'P200.COD_VOCE, P200.COD_VOCE_SPECIALE, P200.DESCRIZIONE,' || chr(10) || 'SUBSTR(P200.COD_CAUSALEIRPEF_ORD,7,4) COD_TRIBUTO,' || chr(10) || ''''' COD_ENTE, ''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE,' || chr(10) || 'TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'')) ANNO, P442.IMPORTO IMPORTO_CREDITO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P200_VOCI P200' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini) AND P441.TIPO_CEDOLINO <> ''RP''' || chr(10) || 'AND P442.COD_VOCE||P442.COD_VOCE_SPECIALE IN (''13160BASE'',''13162CONG'')' || chr(10) || 'AND P442.TIPO_RECORD = ''M'' AND P200.ID_VOCE = P442.ID_VOCE' || chr(10) || 'UNION ALL' || chr(10) || '-- Rimborsi da modello 730' || chr(10) || 'SELECT P441.PROGRESSIVO, DECODE(P260.TIPO_ENTE,''N'',''F'',''R'',''R'',''C'',''S'') TIPO_RIGA,' || chr(10) || 'P200.COD_VOCE, P200.COD_VOCE_SPECIALE, P200.DESCRIZIONE,' || chr(10) || 'SUBSTR(P200.COD_CAUSALEIRPEF_ORD,7,4) COD_TRIBUTO,' || chr(10) || 'P264.COD_ENTE, ''0000'' MESE,' || chr(10) || 'P260.ANNO - 1 ANNO, P442.IMPORTO IMPORTO_CREDITO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P200_VOCI P200,' || chr(10) || '     P260_MOD730TIPOIMPORTI P260, P264_MOD730IMPORTI P264,' || chr(10) || '     T480_COMUNI T480, T482_REGIONI T482' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini) AND P441.TIPO_CEDOLINO <> ''RP''' || chr(10) || 'AND P442.TIPO_RECORD = ''M'' AND P200.ID_VOCE = P442.ID_VOCE AND P200.IMPORTO_COLONNA=''C'' AND' || chr(10) || '(' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE) OR' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE_INT_RATE AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE_INT_RATE) OR' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE_INT_RITARDO AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE_INT_RITARDO)' || chr(10) || ') AND' || chr(10) || 'TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'') = P260.ANNO AND' || chr(10) || 'P260.ANNO = P264.ANNO AND P260.COD_TIPOIMPORTO = P264.COD_TIPOIMPORTO AND' || chr(10) || 'P264.PROGRESSIVO = P441.PROGRESSIVO AND' || chr(10) || 'P264.COD_ENTE = T480.CODCATASTALE(+) AND P264.COD_ENTE = T482.COD_REGIONE(+)' || chr(10) || ') Q, T030_ANAGRAFICO T030' || chr(10) || 'WHERE Q.PROGRESSIVO IN (SELECT PROGRESSIVO FROM :C700SelAnagrafe)' || chr(10) || 'AND Q.PROGRESSIVO = T030.PROGRESSIVO AND IMPORTO_CREDITO<>0' || chr(10) || 'ORDER BY T030.COGNOME, T030.NOME, T030.MATRICOLA, TIPO_RIGA, COD_ENTE, COD_TRIBUTO, ANNO', 
        '-- Bonus per la riduzione del cuneo fiscale' || chr(10) || 'SELECT P441.PROGRESSIVO, ''F'' TIPO_RIGA,' || chr(10) || 'P200.COD_VOCE, P200.COD_VOCE_SPECIALE, P200.DESCRIZIONE,' || chr(10) || 'SUBSTR(P200.COD_CAUSALEIRPEF_ORD,7,4) COD_TRIBUTO,' || chr(10) || ''''' COD_ENTE, ''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE,' || chr(10) || 'TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'')) ANNO, P442.IMPORTO IMPORTO_CREDITO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P200_VOCI P200' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini) AND P441.TIPO_CEDOLINO <> ''RP''' || chr(10) || 'AND P442.COD_VOCE||P442.COD_VOCE_SPECIALE IN (''13160BASE'',''13162CONG'')' || chr(10) || 'AND P442.TIPO_RECORD = ''M'' AND P200.ID_VOCE = P442.ID_VOCE' || chr(10) || 'UNION ALL' || chr(10) || '-- Rimborsi da modello 730' || chr(10) || 'SELECT P441.PROGRESSIVO, DECODE(P260.TIPO_ENTE,''N'',''F'',''R'',''R'',''C'',''S'') TIPO_RIGA,' || chr(10) || 'P200.COD_VOCE, P200.COD_VOCE_SPECIALE, P200.DESCRIZIONE,' || chr(10) || 'SUBSTR(P200.COD_CAUSALEIRPEF_ORD,7,4) COD_TRIBUTO,' || chr(10) || 'P264.COD_ENTE, ''0000'' MESE,' || chr(10) || 'P260.ANNO - 1 ANNO, P442.IMPORTO IMPORTO_CREDITO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P200_VOCI P200,' || chr(10) || '     P260_MOD730TIPOIMPORTI P260, P264_MOD730IMPORTI P264,' || chr(10) || '     T480_COMUNI T480, T482_REGIONI T482' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini) AND P441.TIPO_CEDOLINO <> ''RP''' || chr(10) || 'AND P442.TIPO_RECORD = ''M'' AND P200.ID_VOCE = P442.ID_VOCE AND P200.IMPORTO_COLONNA=''C'' AND' || chr(10) || '(' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE) OR' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE_INT_RATE AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE_INT_RATE) OR' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE_INT_RITARDO AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE_INT_RITARDO)' || chr(10) || ') AND' || chr(10) || 'TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'') = P260.ANNO AND' || chr(10) || 'P260.ANNO = P264.ANNO AND P260.COD_TIPOIMPORTO = P264.COD_TIPOIMPORTO AND' || chr(10) || 'P264.PROGRESSIVO = P441.PROGRESSIVO AND' || chr(10) || 'P264.COD_ENTE = T480.CODCATASTALE(+) AND P264.COD_ENTE = T482.COD_REGIONE(+)' || chr(10) || ') Q, T030_ANAGRAFICO T030' || chr(10) || 'WHERE Q.PROGRESSIVO IN (SELECT PROGRESSIVO FROM :C700SelAnagrafe)' || chr(10) || 'AND Q.PROGRESSIVO = T030.PROGRESSIVO AND IMPORTO_CREDITO<>0' || chr(10) || 'ORDER BY T030.COGNOME, T030.NOME, T030.MATRICOLA, TIPO_RIGA, COD_ENTE, COD_TRIBUTO, ANNO', 
        'N', null, null, null, null, null, null, null);
	
-- INIZIO CREAZIONE INCARICO DR025-010-2010

declare
  i integer;
begin
  select COUNT(*) into i from P441_CEDOLINO;
  if i > 0 then
    select COUNT(*) into i from P250_VOCIAGGIUNTIVE t where T.COD_CONTRATTO ='EDP' AND T.NOME_VOCEAGGIUNTIVA = 'INCARICO';
    if i > 0 then

      INSERT INTO I501INCARICO SELECT 'DR025-010-2010','Dirigente ruolo sanitario < 5 anni con struttura semplice (dec. 2010-2015)' FROM DUAL WHERE NOT EXISTS (SELECT 'X' FROM I501INCARICO T WHERE T.CODICE='DR025-010-2010');
      INSERT INTO P252_VOCIAGGIUNTIVEIMPORTI
      SELECT COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, 'DR025-010-2010', DECORRENZA, 'Dir. ruolo sanitario < 5 anni con S.S. (dec. 2010-2015)', COD_VOCE, COD_VOCE_SPECIALE,
             611.66 IMPORTO,
             EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ
      FROM P252_VOCIAGGIUNTIVEIMPORTI P252
      WHERE P252.COD_CONTRATTO='EDP' AND P252.NOME_VOCEAGGIUNTIVA='INCARICO'
      AND P252.CODICE='DR020-010-2010' AND P252.COD_VOCE='00212' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_CONTRATTO='EDP'
                  AND T.NOME_VOCEAGGIUNTIVA='INCARICO' AND T.CODICE='DR025-010-2010');

    end if;
  end if;
end;
/
-- FINE CREAZIONE INCARICO DR025-010-2010

-- AGGIORNAMENTO TABELLA 770
create table AGG_94_P602 as select * from P602_770REGOLE;

drop table P602_770REGOLE;

create table P602_770REGOLE
(
  anno                      NUMBER(4) not null,
  parte                     VARCHAR2(5) not null,
  numero                    VARCHAR2(4) not null,
  parte_cud                 VARCHAR2(5),
  numero_cud                VARCHAR2(4),
  descrizione               VARCHAR2(150),
  numerico                  VARCHAR2(1) default 'S',
  cod_arrotondamento        VARCHAR2(5),
  formato                   VARCHAR2(11),
  ometti_vuoto              VARCHAR2(1) default 'S',
  regola_calcolo_automatica VARCHAR2(4000),
  regola_calcolo_manuale    VARCHAR2(4000),
  regola_modificabile       VARCHAR2(1) default 'N',
  commento                  VARCHAR2(300),
  tipo_record_file          VARCHAR2(1),
  sezione_file              VARCHAR2(2),
  numero_file               VARCHAR2(3),
  formato_speciale_file     VARCHAR2(1) default 'N',
  numero_speciale_file      varchar2(3),
  formato_file              VARCHAR2(5),
  cod_arrotondamento_file   VARCHAR2(5)
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column P602_770REGOLE.parte
  is 'Parte o sezione del 770';
comment on column P602_770REGOLE.numero
  is 'Numero del dato o codice interno';
comment on column P602_770REGOLE.parte_cud
  is 'Parte o sezione del CUD collegata';
comment on column P602_770REGOLE.numero_cud
  is 'Numero del dato o codice interno del CUD collegato';
comment on column P602_770REGOLE.numerico
  is 'Dato numerico (S/N)';
comment on column P602_770REGOLE.cod_arrotondamento
  is 'Codice arrotondamento. Richiesto solo se dato numerico';
comment on column P602_770REGOLE.formato
  is 'Formato di stampa. Richiesto solo se dato numerico';
comment on column P602_770REGOLE.ometti_vuoto
  is 'Ometti se dato non significativo';
comment on column P602_770REGOLE.regola_calcolo_automatica
  is 'Query per estrazione dato prevista di default';
comment on column P602_770REGOLE.regola_calcolo_manuale
  is 'Query per estrazione dato modificata dall''utente';
comment on column P602_770REGOLE.regola_modificabile
  is 'Query per estrazione dato modificabile dall''utente';
comment on column P602_770REGOLE.tipo_record_file
  is 'Tipo record del file di esportazione, valori ammessi: A,B,E,F,G,H,Z';
comment on column P602_770REGOLE.sezione_file
  is 'Sezione sul file di esportazione, es.: ST,SX DA,DB,DC,DD AU';
comment on column P602_770REGOLE.numero_file
  is 'Numero sul file di esportazione';
comment on column P602_770REGOLE.formato_speciale_file
  is 'Indica se il campo prevede una gestione speciale sul file: N=Nessuna gestione speciale, P=Contiene cassa previdenziale, C=Detrazione coniuge-figlio, S=Sdoppiatura del dato anno/mese';
comment on column P602_770REGOLE.numero_speciale_file
  is 'Numero sul file da utilizzarsi nel caso in cui il campo preveda una gestione speciale sul file stesso';
comment on column P602_770REGOLE.formato_file
  is 'Formato dati per il file di esportazione';
comment on column P602_770REGOLE.cod_arrotondamento_file
  is 'Codice arrotondamento in fase di esportazione. Richiesto solo se dato numerico';

alter table P602_770REGOLE
  add constraint P602_PK primary key (ANNO, PARTE, NUMERO)
  using index 
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);

insert into P602_770REGOLE
(anno, parte, numero, parte_cud, numero_cud, descrizione, numerico, cod_arrotondamento, formato, ometti_vuoto, 
 regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, 
 tipo_record_file, sezione_file, numero_file, formato_speciale_file, numero_speciale_file, formato_file, 
 cod_arrotondamento_file
)
select anno, parte, numero, parte_cud, numero_cud, descrizione, numerico, cod_arrotondamento, formato, ometti_vuoto, 
  regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, 
  tipo_record, sezione_file, numero_file, formato_annomese, '', formato_file, 
  cod_arrotondamento_file
 from AGG_94_P602;

update P502_CUDREGOLE P502 set P502.DESCRIZIONE='Reddito frontalieri' where P502.ANNO=2014 and P502.PARTE='B' and P502.NUMERO='175';
