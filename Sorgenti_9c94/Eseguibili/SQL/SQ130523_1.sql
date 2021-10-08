alter table T282_MESSAGGI add RICEVENTE varchar2(30);
comment on column T282_MESSAGGI.RICEVENTE is 'Nome descrittivo del ricevente, abilitato solo se operatore di I070 e se abilitata la risposta';

alter table T082_PAR_PIANIFORARI add generazione varchar2(1);
alter table T082_PAR_PIANIFORARI add iniziale varchar2(1);
alter table T082_PAR_PIANIFORARI add corrente varchar2(1);
comment on column T082_PAR_PIANIFORARI.generazione
  is 'Abilita generazione pianificazione ricorrente';
comment on column T082_PAR_PIANIFORARI.iniziale
  is 'Abilita accesso a pianificazione ricorrente iniziale';
comment on column T082_PAR_PIANIFORARI.corrente
  is 'Abilita accesso alla pianificazione ricorrente coerrente ';  

update T082_PAR_PIANIFORARI T082 
   set T082.GENERAZIONE = 'S',
       T082.INIZIALE = 'S',
       T082.CORRENTE = 'S';

alter table M065_TARIFFE_INDENNITA modify DECORRENZA_FINE NULL/*--NOLOG--*/;
alter table M021_TIPIINDENNITAKM modify DECORRENZA_FINE NULL/*--NOLOG--*/;

comment on column T162_INDENNITA.ASSENZE_ABILITATE_PROP is 'Obsoleto'/*--NOLOG--*/;
alter table T162_INDENNITA drop column ASSENZE_ABILITATE_PROP/*--NOLOG--*/;
alter table T162_INDENNITA add MATURAZ_PROP_DEBITOGG varchar2(1) default 'N';
comment on column T162_INDENNITA.MATURAZ_PROP_DEBITOGG is 'La maturazione è proporzionata alle ore rese rispetto al debito gg';

update sg751_parprotocollodati
set descrizione = decode(tipo,
                         'SENDERLIST[0].TYPECODE','senderList.typeCode (1°)',
                         'SENDERLIST[1].TYPECODE','senderList.typeCode (2°)',
                         'RECIPIENTLIST.TYPECODE','recipientList.typeCode',
                         descrizione);

alter table P254_VOCIPROGRAMMATE add NOTE varchar2(2000);
comment on column P254_VOCIPROGRAMMATE.NOTE is 'Note';

-- *********************************************************************************
-- AGGIORNAMENTO SCAGLIONE ANNO 2014 DETRAZIONI ASSICURATIVE
-- Art. 12 del DECRETO-LEGGE 31 agosto 2013, n. 102 convertito, con modificazioni, nella Legge n. 124/2013 
-- *********************************************************************************
declare 

  CURSOR C1 IS  
  select P200.COD_CONTRATTO, P200.COD_VOCE, P200.COD_VOCE_SPECIALE, P232.ID_SCAGLIONE,
         P232.DECORRENZA, P233.IMPORTO_A
  from P200_VOCI P200, P232_SCAGLIONI P232, P233_SCAGLIONIFASCE P233
  WHERE P200.COD_CONTRATTO=P232.COD_CONTRATTO AND P200.COD_VOCE=P232.COD_VOCE AND P200.COD_VOCE_SPECIALE=P232.COD_VOCE_SPECIALE
  AND TO_DATE('31012013','DDMMYYYY') BETWEEN P200.DECORRENZA AND P200.DECORRENZA_FINE
  AND UPPER(P200.DESCRIZIONE) LIKE '%ASSICURAZION%'
  AND P232.COD_VOCE='11402' AND P232.COD_VOCE_SPECIALE='BASE'
  AND P232.DECORRENZA=TO_DATE('01012014','DDMMYYYY') AND P233.ID_SCAGLIONE=P232.ID_SCAGLIONE
  AND P233.IMPORTO_DA=0 AND P233.IMPORTO_A=230;

begin
  FOR T1 IN C1 LOOP

    UPDATE P233_SCAGLIONIFASCE P233 SET P233.IMPORTO_A=530 WHERE P233.IMPORTO_DA=0
    AND P233.ID_SCAGLIONE=T1.ID_SCAGLIONE;

    UPDATE P233_SCAGLIONIFASCE P233 SET P233.IMPORTO_DA=530.01 WHERE P233.IMPORTO_A=0
    AND P233.ID_SCAGLIONE=T1.ID_SCAGLIONE;

  END LOOP;
end;

/
-- *********************************************************************************
-- FINE AGGIORNAMENTO SCAGLIONE ANNO 2014 DETRAZIONI ASSICURATIVE
-- *********************************************************************************

-----
-- Inizio A.N.A.A.O. - ASSOMED per EDPSC
-----
  
declare 
  i integer;
  ID_P200 integer;
  CodVoceModello varchar2(5);
  CodVoceCopia varchar2(5);
  DesVoceCopia varchar2(40);
  DesVoceCopiaSt varchar2(40);

begin
CodVoceModello:='12771';
CodVoceCopia:='12746';
DesVoceCopia:='A.N.A.A.O. - ASSOMED';
DesVoceCopiaSt:='A.N.A.A.O. - ASSOMED';

  select COUNT(*) into i from P200_VOCI t 
    where T.COD_CONTRATTO ='EDPSC' and T.COD_VOCE=CodVoceModello and T.COD_VOCE_SPECIALE='BASE'
    and not exists
    (select 'X' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce=CodVoceCopia
       and v.cod_voce_speciale=t.cod_voce_speciale);
  if i > 0 then

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario, importo_massimo from p200_voci T
WHERE T.COD_CONTRATTO='EDPSC' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDPSC' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-----
-- Fine A.N.A.A.O. - ASSOMED per EDPSC
-----

  end if;
end;
/

-- INIZIO CREAZIONE POSIZIONE ECONOMICA DR011 COPIANDOLA DA DR016

declare 
  ID_P221 integer;
  
  CURSOR C1 IS  
  select * from p220_livelli t where T.COD_CONTRATTO='EDP' AND t.cod_posizione_economica='DR016'
  and not exists
  (select 'X' from p220_livelli t where T.COD_CONTRATTO='EDP' AND t.cod_posizione_economica='DR011')
  order by t.decorrenza;

begin
  FOR T1 IN C1 LOOP

  SELECT P221_ID_LIVELLO.NEXTVAL INTO ID_P221 FROM DUAL;

  insert into p220_livelli
    (cod_contratto, cod_posizione_economica, decorrenza, id_livello, categoria_economica, cod_livello, descrizione, decorrenza_fine, cod_posizione_economica_succ)
  values
    (t1.cod_contratto, 'DR011', t1.decorrenza, ID_P221, t1.categoria_economica, t1.cod_livello, 
    'Dirigente sanitario I livello (ex 10° qualificato legge 724/94)', 
    t1.decorrenza_fine, t1.cod_posizione_economica_succ);
   
  INSERT INTO P221_LIVELLIIMPORTI
  select ID_P221, cod_voce, cod_voce_speciale, importo, erogazione_mesi from p221_livelliimporti v
  where v.id_livello=t1.id_livello;
  
  UPDATE P221_LIVELLIIMPORTI T SET T.IMPORTO=454.65 
  where t.id_livello=ID_P221 and t.cod_voce='00210' and t.importo=399.44;

  UPDATE P221_LIVELLIIMPORTI T SET T.IMPORTO=483.81 
  where t.id_livello=ID_P221 and t.cod_voce='00210' and t.importo=428.61;

  UPDATE P221_LIVELLIIMPORTI T SET T.IMPORTO=525.48 
  where t.id_livello=ID_P221 and t.cod_voce='00210' and t.importo=470.28;

  UPDATE P221_LIVELLIIMPORTI T SET T.IMPORTO=151.43 
  where t.id_livello=ID_P221 and t.cod_voce='00215' and t.importo=105.01;

  UPDATE P221_LIVELLIIMPORTI T SET T.IMPORTO=220.33 
  where t.id_livello=ID_P221 and t.cod_voce='00208' and t.importo=110.38;

  END LOOP;

end;

/

-- FINE CREAZIONE POSIZIONE ECONOMICA DR011 COPIANDOLA DA DR016

-- INIZIO CREAZIONE INCARICO DR021-011-2010

declare
  i integer;
begin
  select COUNT(*) into i from P441_CEDOLINO;
  if i > 0 then
    select COUNT(*) into i from P250_VOCIAGGIUNTIVE t where T.COD_CONTRATTO ='EDP' AND T.NOME_VOCEAGGIUNTIVA = 'INCARICO';
    if i > 0 then

      INSERT INTO I501INCARICO SELECT 'DR021-011-2010','Dirigente ruolo sanitario equiparato (legge 724/94) con struttura semplice (dec. 2010-2014)' FROM DUAL WHERE NOT EXISTS (SELECT 'X' FROM I501INCARICO T WHERE T.CODICE='DR021-011-2010');
      INSERT INTO P252_VOCIAGGIUNTIVEIMPORTI
      SELECT COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, 'DR021-011-2010', DECORRENZA, 'Dir. ruolo sanitario equiparato (legge 724/94) con S.S. (dec. 2010-2014)', COD_VOCE, COD_VOCE_SPECIALE,
             109.95 IMPORTO,
             EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ
      FROM P252_VOCIAGGIUNTIVEIMPORTI P252
      WHERE P252.COD_CONTRATTO='EDP' AND P252.NOME_VOCEAGGIUNTIVA='INCARICO'
      AND P252.CODICE='DR020-010-2010' AND P252.COD_VOCE='00212' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_CONTRATTO='EDP'
                  AND T.NOME_VOCEAGGIUNTIVA='INCARICO' AND T.CODICE='DR021-011-2010');

    end if;
  end if;
end;
/

-- FINE CREAZIONE INCARICO DR021-011-2010

-- AGGIORNAMENTO TABELLE DI ASSENTEISMO E FORZA LAVORO IN BASE ALLE NUOVE COLONNE PER LA STATISTICA BRUNETTA

UPDATE T151_ASSENTEISMO SET COLONNE = REPLACE(REPLACE(COLONNE,'406','506'),'407','507');

INSERT INTO t151_assenteismo
  (codice, descrizione, cod_tipoaccorpcausali, cod_codiciaccorpcausali, modo_accorpcausali, stampa_generatore, righe, righe_vuote, dettaglio_dip, colonne, numdip_periodo, 
numdip_arrot, presenza_gglav, presenza_arrot, assenza_gglav, assenza_qm, assenza_ggint, assenza_arrot, riepilogo_arrot, ass_familiari, 
ass_fruizione_gg, ass_fruizione_mg, ass_fruizione_hh, ass_fruizione_dh, ass_maxperiodo_gg, ass_debito_ggint, totale_generale, esporta_xml)
VALUES
  ('MONMENASS1', 'MONITORAGGIO MENSILE ASSENZE MALATTIA', '', '', 'D', '_ASSPRES', '001#SESSO', 'N', 'N', '302,303,406', 'I', 
'N', 'N', 'N', 'S', 'N', 'N', 'N', 'N', '', 
'S', 'S', 'S', 'S', 9999, 'C', 'S', 'N');

INSERT INTO t151_assenteismo
  (codice, descrizione, cod_tipoaccorpcausali, cod_codiciaccorpcausali, modo_accorpcausali, stampa_generatore, righe, righe_vuote, dettaglio_dip, colonne, numdip_periodo, 
numdip_arrot, presenza_gglav, presenza_arrot, assenza_gglav, assenza_qm, assenza_ggint, assenza_arrot, riepilogo_arrot, ass_familiari, 
ass_fruizione_gg, ass_fruizione_mg, ass_fruizione_hh, ass_fruizione_dh, ass_maxperiodo_gg, ass_debito_ggint, totale_generale, esporta_xml)
VALUES
  ('MONMENASS2', 'MONITORAGGIO MENSILE ASSENZE ALTRE-L104', '', '', 'D', '_ASSPRES', '001#SESSO', 'N', 'N', '102,300,405', 'I', 
'N', 'N', 'N', 'S', 'N', 'N', 'N', 'N', '', 
'S', 'S', 'S', 'S', 9999, 'C', 'S', 'N');


