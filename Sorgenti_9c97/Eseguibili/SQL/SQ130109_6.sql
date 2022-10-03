alter table T025_CONTMENSILI add ITER_ECCGG_CHECKSALDO varchar2(1) default 'N';

declare
  i integer;
begin
  select COUNT(*) into i from P042_ENTIIRPEF;
  if i = 0 then
    insert into I050_SCRIPTSQL (NOME) values ('SQ130109_6AddIRPEF.sql');
  end if;
exception
  when others then
    insert into I050_SCRIPTSQL (NOME) values ('SQ130109_6AddIRPEF.sql');
end/*--NOLOG--*/;
/

UPDATE t480_comuni t SET T.CITTA='CASTROCARO TERME E TERRA DEL SOLE' WHERE T.CODCATASTALE='C339';
UPDATE t480_comuni t SET T.CITTA='SAN GIORGIO DELLA RICHINVELDA' WHERE T.CODCATASTALE='H891';
UPDATE t480_comuni t SET T.CITTA='SOTTO IL MONTE GIOVANNI XXIII' WHERE T.CODCATASTALE='I869';
UPDATE t480_comuni t SET T.CITTA='REGGIO NELL''EMILIA' WHERE T.CODCATASTALE='H223';

alter table P264_MOD730IMPORTI add PERC_PRIMA_RATA NUMBER;
comment on column P264_MOD730IMPORTI.PERC_PRIMA_RATA
  is 'Eventuale percentuale di rimborso su prima rata (Luglio) per insufficienza di ritenute IRPEF';

--
-- Inizio creazione storia posizione economica MV050
--

declare 
  i integer;
  ID_P221 integer;
  
  CURSOR C1 IS  
  select * from P220_LIVELLI t 
  where t.cod_contratto='EDP' and t.cod_posizione_economica='MV006'
        and to_char(t.decorrenza,'dd/mm/yyyy') in ('01/07/2001','01/01/2002','01/01/2003','01/01/2004','01/02/2005',
                                                   '01/01/2006','01/02/2007','01/01/2008','01/01/2009','01/04/2010')
  order by t.decorrenza;

begin
  
select COUNT(*) into i from P220_LIVELLI t 
where t.cod_contratto='EDP' and t.cod_posizione_economica='MV050';

if i > 0 then

  DELETE P220_LIVELLI t 
  where t.cod_contratto='EDP' and t.cod_posizione_economica='MV050'
        and to_char(t.decorrenza,'dd/mm/yyyy') not in ('01/01/1900','01/07/2010');

  FOR T1 IN C1 LOOP
    SELECT P221_ID_LIVELLO.NEXTVAL INTO ID_P221 FROM DUAL;
   
    insert into p220_livelli
      (cod_contratto, cod_posizione_economica, decorrenza, id_livello, categoria_economica, cod_livello, descrizione, decorrenza_fine, cod_posizione_economica_succ)
    values
      (T1.cod_contratto, 'MV050', T1.decorrenza, ID_P221, T1.categoria_economica, T1.cod_livello, 'Ex medici condotti ed equiparati', T1.decorrenza_fine, T1.cod_posizione_economica_succ);
  
    insert into P221_LIVELLIIMPORTI
    select ID_P221, cod_voce, cod_voce_speciale, importo, erogazione_mesi from p221_livelliimporti t
      where t.id_livello=t1.id_livello and t.cod_voce in ('00025','00100','00290');

  END LOOP; 

  update P221_LIVELLIIMPORTI t set t.importo=499.47
    where t.cod_voce='00025' and t.cod_voce_speciale='BASE' and t.id_livello =
      (select v.id_livello from p220_livelli v where v.cod_contratto='EDP' and v.cod_posizione_economica='MV050'
         and v.decorrenza=to_date('01072001','ddmmyyyy'));
  update P221_LIVELLIIMPORTI t set t.importo=506.02
    where t.cod_voce='00100' and t.cod_voce_speciale='BASE' and t.id_livello =
      (select v.id_livello from p220_livelli v where v.cod_contratto='EDP' and v.cod_posizione_economica='MV050'
         and v.decorrenza=to_date('01072001','ddmmyyyy'));
  
  update P221_LIVELLIIMPORTI t set t.importo=511.82
    where t.cod_voce='00025' and t.cod_voce_speciale='BASE' and t.id_livello =
      (select v.id_livello from p220_livelli v where v.cod_contratto='EDP' and v.cod_posizione_economica='MV050'
         and v.decorrenza=to_date('01012002','ddmmyyyy'));
  update P221_LIVELLIIMPORTI t set t.importo=506.02
    where t.cod_voce='00100' and t.cod_voce_speciale='BASE' and t.id_livello =
      (select v.id_livello from p220_livelli v where v.cod_contratto='EDP' and v.cod_posizione_economica='MV050'
         and v.decorrenza=to_date('01012002','ddmmyyyy'));

  update P221_LIVELLIIMPORTI t set t.importo=1035.35
    where t.cod_voce='00025' and t.cod_voce_speciale='BASE' and t.id_livello =
      (select v.id_livello from p220_livelli v where v.cod_contratto='EDP' and v.cod_posizione_economica='MV050'
         and v.decorrenza=to_date('01012003','ddmmyyyy'));
    
  update P221_LIVELLIIMPORTI t set t.importo=1045.41
    where t.cod_voce='00025' and t.cod_voce_speciale='BASE' and t.id_livello =
      (select v.id_livello from p220_livelli v where v.cod_contratto='EDP' and v.cod_posizione_economica='MV050'
         and v.decorrenza=to_date('01012004','ddmmyyyy'));
    
  update P221_LIVELLIIMPORTI t set t.importo=1062.35
    where t.cod_voce='00025' and t.cod_voce_speciale='BASE' and t.id_livello =
      (select v.id_livello from p220_livelli v where v.cod_contratto='EDP' and v.cod_posizione_economica='MV050'
         and v.decorrenza=to_date('01022005','ddmmyyyy'));
    
  update P221_LIVELLIIMPORTI t set t.importo=1064.35
    where t.cod_voce='00025' and t.cod_voce_speciale='BASE' and t.id_livello =
      (select v.id_livello from p220_livelli v where v.cod_contratto='EDP' and v.cod_posizione_economica='MV050'
         and v.decorrenza=to_date('01012006','ddmmyyyy'));
    
  update P221_LIVELLIIMPORTI t set t.importo=1087.25
    where t.cod_voce='00025' and t.cod_voce_speciale='BASE' and t.id_livello =
      (select v.id_livello from p220_livelli v where v.cod_contratto='EDP' and v.cod_posizione_economica='MV050'
         and v.decorrenza=to_date('01022007','ddmmyyyy'));
    
  update P221_LIVELLIIMPORTI t set t.importo=1089.57
    where t.cod_voce='00025' and t.cod_voce_speciale='BASE' and t.id_livello =
      (select v.id_livello from p220_livelli v where v.cod_contratto='EDP' and v.cod_posizione_economica='MV050'
         and v.decorrenza=to_date('01012008','ddmmyyyy'));
    
  update P221_LIVELLIIMPORTI t set t.importo=1105.85
    where t.cod_voce='00025' and t.cod_voce_speciale='BASE' and t.id_livello =
      (select v.id_livello from p220_livelli v where v.cod_contratto='EDP' and v.cod_posizione_economica='MV050'
         and v.decorrenza=to_date('01012009','ddmmyyyy'));
    
  update P221_LIVELLIIMPORTI t set t.importo=1105.85
    where t.cod_voce='00025' and t.cod_voce_speciale='BASE' and t.id_livello =
      (select v.id_livello from p220_livelli v where v.cod_contratto='EDP' and v.cod_posizione_economica='MV050'
         and v.decorrenza=to_date('01042010','ddmmyyyy'));
  update P221_LIVELLIIMPORTI t set t.importo=4.89
    where t.cod_voce='00290' and t.cod_voce_speciale='BASE' and t.id_livello =
      (select v.id_livello from p220_livelli v where v.cod_contratto='EDP' and v.cod_posizione_economica='MV050'
         and v.decorrenza=to_date('01042010','ddmmyyyy'));
 
  UPDATE P220_LIVELLI t SET T.DECORRENZA_FINE=
    (SELECT MIN(V.DECORRENZA) - 1 FROM P220_LIVELLI V
     WHERE V.COD_CONTRATTO=T.COD_CONTRATTO AND V.COD_POSIZIONE_ECONOMICA=T.COD_POSIZIONE_ECONOMICA
     AND V.DECORRENZA>T.DECORRENZA)
  WHERE T.COD_CONTRATTO='EDP' AND T.COD_POSIZIONE_ECONOMICA='MV050'
  AND T.DECORRENZA_FINE <> TO_DATE('31123999','DDMMYYYY');
  
end if;

end;

/

--
-- Fine creazione storia posizione economica MV050
--

-- Creazione nuova tabella recupero voci 

create table P454_RECUPERO_VOCI
( PROGRESSIVO         NUMBER NOT NULL,
  DATA_RETRIBUZIONE   DATE NOT NULL,
  COD_CONTRATTO       VARCHAR2(5) NOT NULL,		
  COD_VOCE	      VARCHAR2(5) NOT NULL,		
  COD_VOCE_SPECIALE   VARCHAR2(5) NOT NULL,		
  IMPORTO             NUMBER NOT NULL) 
tablespace LAVORO
  storage (initial 256K next 256K pctincrease 0);

comment on column P454_RECUPERO_VOCI.PROGRESSIVO is 'Progressivo del dipendente';
comment on column P454_RECUPERO_VOCI.DATA_RETRIBUZIONE is 'Anno e mese di retribuzione';
comment on column P454_RECUPERO_VOCI.COD_CONTRATTO is 'Contratto voci';
comment on column P454_RECUPERO_VOCI.COD_VOCE is 'Codice voce';
comment on column P454_RECUPERO_VOCI.COD_VOCE_SPECIALE is 'Codice voce speciale';
comment on column P454_RECUPERO_VOCI.IMPORTO is 'Importo da recuperare o recuperato';

-- *********************************************************************************
-- INIZIO CREAZIONE NUOVI SCAGLIONI ANNI 2013 E 2014 DETRAZIONI ASSICURATIVE
-- Art. 12 del DECRETO-LEGGE 31 agosto 2013, n. 102
-- *********************************************************************************
declare 
  ID_P233 integer;

  CURSOR C1 IS  
  select P200.COD_CONTRATTO, P200.COD_VOCE, P200.COD_VOCE_SPECIALE, T.ID_SCAGLIONE from P200_VOCI P200, P232_SCAGLIONI T
  WHERE P200.COD_CONTRATTO=T.COD_CONTRATTO AND P200.COD_VOCE=T.COD_VOCE AND P200.COD_VOCE_SPECIALE=T.COD_VOCE_SPECIALE
  AND TO_DATE('31012013','DDMMYYYY') BETWEEN P200.DECORRENZA AND P200.DECORRENZA_FINE
  AND UPPER(P200.DESCRIZIONE) LIKE '%ASSICURAZION%'
  AND T.COD_VOCE='11402' AND T.COD_VOCE_SPECIALE='BASE'
  AND T.DECORRENZA=TO_DATE('01011900','DDMMYYYY') AND NOT EXISTS
  (select 'X' from P232_SCAGLIONI V
  WHERE V.COD_CONTRATTO=T.COD_CONTRATTO AND V.COD_VOCE=T.COD_VOCE AND V.COD_VOCE_SPECIALE=T.COD_VOCE_SPECIALE
  AND V.DECORRENZA<>TO_DATE('01011900','DDMMYYYY'))
  ORDER BY P200.COD_CONTRATTO, P200.COD_VOCE, P200.COD_VOCE_SPECIALE;

begin
  FOR T1 IN C1 LOOP

    -- Anno 2013
    SELECT P233_ID_SCAGLIONE.NEXTVAL INTO ID_P233 FROM DUAL;
   
    INSERT INTO P232_SCAGLIONI
    SELECT COD_CONTRATTO, COD_VOCE, COD_VOCE_SPECIALE, TO_DATE('01012013','DDMMYYYY'), ID_P233, TIPO_IMPORTO, TIPO_RITENUTA, TIPO_APPLICAZIONE, CONGUAGLIO_ANNUALE, CONGUAGLIO_FINE_RAPPORTO, CONGUAGLIO_DOPO_FINE_RAPPORTO, COD_VOCE_CONGUAGLIO, COD_VOCE_SPECIALE_CONGUAGLIO, MENSILITA_ANNUE, MASSIMALE1, MASSIMALE2 FROM P232_SCAGLIONI P232 
    WHERE P232.ID_SCAGLIONE=T1.ID_SCAGLIONE;
  
    INSERT INTO P233_SCAGLIONIFASCE
    SELECT ID_P233, IMPORTO_DA, IMPORTO_A, PERC_IMP FROM P233_SCAGLIONIFASCE P233
    WHERE P233.ID_SCAGLIONE=T1.ID_SCAGLIONE;

    UPDATE P233_SCAGLIONIFASCE P233 SET P233.IMPORTO_A=630 WHERE P233.IMPORTO_DA=0
    AND P233.ID_SCAGLIONE=ID_P233;

    UPDATE P233_SCAGLIONIFASCE P233 SET P233.IMPORTO_DA=630.01 WHERE P233.IMPORTO_A=0
    AND P233.ID_SCAGLIONE=ID_P233;

    -- Anno 2014
    SELECT P233_ID_SCAGLIONE.NEXTVAL INTO ID_P233 FROM DUAL;
   
    INSERT INTO P232_SCAGLIONI
    SELECT COD_CONTRATTO, COD_VOCE, COD_VOCE_SPECIALE, TO_DATE('01012014','DDMMYYYY'), ID_P233, TIPO_IMPORTO, TIPO_RITENUTA, TIPO_APPLICAZIONE, CONGUAGLIO_ANNUALE, CONGUAGLIO_FINE_RAPPORTO, CONGUAGLIO_DOPO_FINE_RAPPORTO, COD_VOCE_CONGUAGLIO, COD_VOCE_SPECIALE_CONGUAGLIO, MENSILITA_ANNUE, MASSIMALE1, MASSIMALE2 FROM P232_SCAGLIONI P232 
    WHERE P232.ID_SCAGLIONE=T1.ID_SCAGLIONE;
  
    INSERT INTO P233_SCAGLIONIFASCE
    SELECT ID_P233, IMPORTO_DA, IMPORTO_A, PERC_IMP FROM P233_SCAGLIONIFASCE P233
    WHERE P233.ID_SCAGLIONE=T1.ID_SCAGLIONE;

    UPDATE P233_SCAGLIONIFASCE P233 SET P233.IMPORTO_A=230 WHERE P233.IMPORTO_DA=0
    AND P233.ID_SCAGLIONE=ID_P233;

    UPDATE P233_SCAGLIONIFASCE P233 SET P233.IMPORTO_DA=230.01 WHERE P233.IMPORTO_A=0
    AND P233.ID_SCAGLIONE=ID_P233;

  END LOOP;
end;

/
-- *********************************************************************************
-- FINE CREAZIONE NUOVI SCAGLIONI ANNI 2013 E 2014 DETRAZIONI ASSICURATIVE
-- *********************************************************************************

-- Aggiunta colonne al parcheggio voci
ALTER TABLE P448_CEDOLINOPARKVOCI ADD DESCRIZIONE_VOCE_SOST VARCHAR2(40); 
COMMENT ON COLUMN P448_CEDOLINOPARKVOCI.DESCRIZIONE_VOCE_SOST IS 'Se significativo sostituisce la descrizione della voce nella stampa del cedolino';
ALTER TABLE P448_CEDOLINOPARKVOCI ADD NOTE VARCHAR2(50); 
COMMENT ON COLUMN P448_CEDOLINOPARKVOCI.NOTE IS 'Note, riferimenti, delibere, ecc.';

-- ********************************************************************
-- INIZIO RICALCOLO SECONDA RATA ACCONTO IRPEF 730 ANNO 2013
-- Art. 11 commi 18 e 19 del DECRETO-LEGGE 28 giugno 2013, n.76
-- ********************************************************************
declare 
  CURSOR C1 IS  
select progressivo, matricola, cognome, nome, anno, tipo_cod, tipo,
       dov_1_rata, pag_1_rata, dov_2_rata_old, pag_2_rata,
       round((dov_1_rata + dov_2_rata_old)/99*100) - dov_1_rata dov_2_rata_new,
       (dov_1_rata + dov_2_rata_old) dov_tot_old,
       round((dov_1_rata + dov_2_rata_old)/99*100) dov_tot_new
from
(
select t030.progressivo,t030.matricola,t030.cognome,t030.nome,p264.anno,p264.cod_tipoimporto tipo_cod,
decode(substr(p264.cod_tipoimporto,3,1),'D','Dichiarante','Coniuge') tipo,
nvl((select p264a.importo_dovuto from p264_mod730importi p264a where p264a.progressivo=p264.progressivo
  and p264a.anno=p264.anno and p264a.cod_tipoimporto='1'||substr(p264.cod_tipoimporto,2,2)),0) dov_1_rata, 
nvl((select p264a.importo_cong_pos + p264a.importo_cong_neg from p264_mod730importi p264a where p264a.progressivo=p264.progressivo
  and p264a.anno=p264.anno and p264a.cod_tipoimporto='1'||substr(p264.cod_tipoimporto,2,2)),0) pag_1_rata, 
p264.importo_dovuto dov_2_rata_old,
p264.importo_cong_pos + p264.importo_cong_neg pag_2_rata 
from p264_mod730importi p264, t030_anagrafico t030
where t030.progressivo=p264.progressivo
and p264.cod_tipoimporto in ('2ID','2IC') and p264.anno=2013 and p264.importo_manuale is null
) q
order by cognome,nome,tipo_cod;

begin

  FOR T1 IN C1 LOOP
    UPDATE P264_MOD730IMPORTI P264 
    SET P264.IMPORTO_MANUALE=T1.DOV_2_RATA_NEW, P264.IMPORTO_DOVUTO=T1.DOV_2_RATA_NEW
    WHERE P264.PROGRESSIVO=T1.PROGRESSIVO AND P264.ANNO=T1.ANNO AND 
          P264.COD_TIPOIMPORTO=T1.TIPO_COD;

    UPDATE P262_MOD730TESTATA P262 
    SET P262.COD_ESITO_2RATA='AU100' 
    WHERE P262.PROGRESSIVO=T1.PROGRESSIVO AND P262.ANNO=T1.ANNO AND
          T1.TIPO_COD='2ID';

    UPDATE P262_MOD730TESTATA P262 
    SET P262.COD_ESITO_2RATA_CONIUGE='AU100' 
    WHERE P262.PROGRESSIVO=T1.PROGRESSIVO AND P262.ANNO=T1.ANNO AND
          T1.TIPO_COD='2IC';

  END LOOP;
 
end;

/
-- ********************************************************************
-- FINE RICALCOLO SECONDA RATA ACCONTO IRPEF 730 ANNO 2013
-- ********************************************************************

-----
-- Inizio creazione voce 02018 - Retr.responsabile prevenzione corruzione
-----
  
declare 
  i integer;
  ID_P200 integer;
  CodVoceModello varchar2(5);
  CodVoceCopia varchar2(5);
  DesVoceCopia varchar2(40);
  DesVoceCopiaSt varchar2(40);

begin
CodVoceModello:='02012';
CodVoceCopia:='02018';
DesVoceCopia:='Retr.responsabile prevenzione corruzione';
DesVoceCopiaSt:='Retr.responsabile prevenzione corruzione';

select COUNT(*) into i from P441_CEDOLINO;
if i > 0 then
  select COUNT(*) into i from P200_VOCI t 
    where T.COD_CONTRATTO ='EDP' and T.COD_VOCE=CodVoceModello and T.COD_VOCE_SPECIALE='BASE'
          and upper(t.descrizione) like upper('%risultato dirig%')
    and not exists
    (select 'X' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce=CodVoceCopia
       and v.cod_voce_speciale=t.cod_voce_speciale);
  if i > 0 then

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario, importo_massimo from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

  end if;
end if;
end;
/

-----
-- Fine creazione voce 02018 - Retr.responsabile prevenzione corruzione
-----

