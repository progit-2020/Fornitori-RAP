alter table T925_SCHEDULAZIONI add FUNZIONE_GG varchar2(2000);
comment on column T925_SCHEDULAZIONI.FUNZIONE_GG is 'Funzione sql che restituisce ''S'' se il giorno corrente deve essere eseguita la schedulazione. Viene valutata come select from dual, non sono previste variabili';

alter table I001_LOGDATI
  add constraint I001_FK_I000 foreign key (ID)
  references I000_LOGINFO (ID) on delete cascade;

alter table T193_VOCIPAGHE_PARAMETRI add voce_paghe_arretrato VARCHAR2(10);
alter table T193_VOCIPAGHE_PARAMETRI add voce_paghe_arretrneg VARCHAR2(10);
comment on column T193_VOCIPAGHE_PARAMETRI.voce_paghe_arretrato
  is 'Voce paghe utilizzata per arretrati determinati da mese competenza < mese cassa -2';
comment on column T193_VOCIPAGHE_PARAMETRI.voce_paghe_arretrneg
  is 'Voce paghe utilizzata per arretrati negativi sempre determinati da mese competenza < mese cassa -2';
  
alter table T193_VOCIPAGHE_PARAMETRI add min_giorn number;
alter table T193_VOCIPAGHE_PARAMETRI add max_giorn number;
alter table T193_VOCIPAGHE_PARAMETRI add arrot_giorn number;
comment on column T193_VOCIPAGHE_PARAMETRI.min_giorn
  is 'Minimo quantitativo giornaliero: applicato se diverso da zero su quantià inferiore al valore specificato';
comment on column T193_VOCIPAGHE_PARAMETRI.max_giorn
  is 'Massimo quantitativo giornaliero: applicato se diverso da zero su quantià superiori al valore specificato';
comment on column T193_VOCIPAGHE_PARAMETRI.arrot_giorn
  is 'Arrotondamento quantitativo giornaliero: applicato se diverso da zero, se positivo arrotonda per eccesso se negativo per difetto';
alter table T269_RELAZIONI_ATTESTATIINPS add stato_causa_malattia varchar2(15);
comment on column T269_RELAZIONI_ATTESTATIINPS.stato_causa_malattia
  is 'Contiene il nome del dato libero della T430_STORICO, che contiene il possibile codice di “Particolari cause di malattia”';
  
-- Inserimento nuovi campi per esportazione CU su file 
alter table P502_CUDREGOLE add tipo_record_file VARCHAR2(1);
alter table P502_CUDREGOLE add codice_file varchar2(8);
alter table P502_CUDREGOLE add formato_speciale_file varchar2(1) default 'N';
alter table P502_CUDREGOLE add codice_speciale_file varchar2(8);
alter table P502_CUDREGOLE add formato_file VARCHAR2(5);
alter table P502_CUDREGOLE add valore_fisso_file VARCHAR2(5);

comment on column P502_CUDREGOLE.tipo_record_file
  is 'Tipo record del file di esportazione: D=dati anagrafici, G=dati lavoro dipendente, H=dati lavoro autonomo';
comment on column P502_CUDREGOLE.codice_file
  is 'Codice campo sul file';
comment on column P502_CUDREGOLE.formato_speciale_file
  is 'Indica se il campo prevede una gestione speciale sul file: N=Nessuna gestione speciale, P=Contiene cassa previdenziale, C=Detrazione coniuge-figlio';
comment on column P502_CUDREGOLE.codice_speciale_file
  is 'Codice campo sul file da utilizzarsi nel caso in cui il campo preveda una gestione speciale sul file stesso';
comment on column P502_CUDREGOLE.formato_file
  is 'Formato dati per il file di esportazione';
comment on column P502_CUDREGOLE.valore_fisso_file
  is 'Valore fisso sul file alternativo al valore calcolato';

-----
-- Inizio U.S.S.M.O. Univ. Sanita' Sind. Med. Osp.
-----
  
declare 
  i integer;
  ID_P200 integer;
  CodVoceModello varchar2(5);
  CodVoceCopia varchar2(5);
  DesVoceCopia varchar2(40);
  DesVoceCopiaSt varchar2(40);

begin
CodVoceModello:='12441';
CodVoceCopia:='12501';
DesVoceCopia:='U.S.S.M.O. Univ. Sanità Sind. Med. Osp.';
DesVoceCopiaSt:='U.S.S.M.O. Univ. Sanita'' Sind. Med. Osp.';

select COUNT(*) into i from P441_CEDOLINO;
if i > 0 then
  select COUNT(*) into i from P200_VOCI t 
    where T.COD_CONTRATTO ='EDP' and T.COD_VOCE=CodVoceModello and T.COD_VOCE_SPECIALE='BASE'
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
-- Fine U.S.S.M.O. Univ. Sanita' Sind. Med. Osp.
-----

-- *********************************************************************************
-- CREAZIONE SCAGLIONI DI INIZIO ANNO E NUOVE PERCENTUALI
-- PER VOCI RELATIVE A CPDEL, CPS, ENPAM EX CONVENZIONATI,
-- INPGI, OPTANTI INPS, PERSONALE RELIGIOSO INPS, GESTIONE SEPARATA INPS E ENPAPI
-- ****************  2015 (FATTO SU SQL PATCH) ****************
-- *********************************************************************************

declare 
  i integer;
  AnnoNuovo integer;
  CodContratto varchar2(5);
  CodVoce varchar2(5);
  CodVoceSpeciale varchar2(5);
  PercDipCP_Fis real;
  PercDipCP_Agg real;
  PercDipGI_1 real;
  PercDipGI_2 real;
  PercDipIN_1 real;
  PercDipIN_2 real;
  PercDipINRel_1 real;
  PercDipINRel_2 real;
  PercDip11110 real;
  PercEnte11115 real;
  PercDip11120 real;
  PercEnte11125 real;
  PercDip11130 real;
  PercEnte11135 real;
  ID_P233 integer;

  CURSOR C1 IS  
  SELECT 'EDP' AS COD_CONTRATTO, '11010' AS COD_VOCE, 'BASE' AS COD_VOCE_SPECIALE FROM DUAL UNION
  SELECT 'EDP', '11010', 'ENTE' FROM DUAL UNION
  SELECT 'EDP', '11017', 'BASE' FROM DUAL UNION

  SELECT 'EDPEL', '11010', 'BASE' FROM DUAL UNION
  SELECT 'EDPEL', '11010', 'ENTE' FROM DUAL UNION
  SELECT 'EDPEL', '11017', 'BASE' FROM DUAL UNION

  SELECT 'EDP', '11020', 'BASE' FROM DUAL UNION
  SELECT 'EDP', '11020', 'ENTE' FROM DUAL UNION
  SELECT 'EDP', '11027', 'BASE' FROM DUAL UNION
   
  SELECT 'EDP', '11090', 'BASE' FROM DUAL UNION

  SELECT 'EDPEL', '11090', 'BASE' FROM DUAL UNION

  SELECT 'EDP', '11110', 'BASE' FROM DUAL UNION
  SELECT 'EDP', '11115', 'BASE' FROM DUAL UNION
  SELECT 'EDP', '11120', 'BASE' FROM DUAL UNION
  SELECT 'EDP', '11125', 'BASE' FROM DUAL UNION
  SELECT 'EDP', '11130', 'BASE' FROM DUAL UNION
  SELECT 'EDP', '11135', 'BASE' FROM DUAL UNION

  SELECT 'EDPEL', '11110', 'BASE' FROM DUAL UNION
  SELECT 'EDPEL', '11115', 'BASE' FROM DUAL UNION
  SELECT 'EDPEL', '11120', 'BASE' FROM DUAL UNION
  SELECT 'EDPEL', '11125', 'BASE' FROM DUAL UNION
  SELECT 'EDPEL', '11130', 'BASE' FROM DUAL UNION
  SELECT 'EDPEL', '11135', 'BASE' FROM DUAL UNION

  SELECT 'EDP', '11140', 'BASE' FROM DUAL UNION
  SELECT 'EDP', '11140', 'ENTE' FROM DUAL UNION
  SELECT 'EDP', '11150', 'BASE' FROM DUAL UNION
  SELECT 'EDP', '11150', 'ENTE' FROM DUAL UNION

  SELECT 'EDPEL', '11140', 'BASE' FROM DUAL UNION
  SELECT 'EDPEL', '11140', 'ENTE' FROM DUAL UNION

  SELECT 'EDP', '11160', 'BASE' FROM DUAL UNION
  SELECT 'EDP', '11170', 'BASE' FROM DUAL UNION

  SELECT 'EDPEL', '11160', 'BASE' FROM DUAL UNION
  SELECT 'EDPEL', '11170', 'BASE' FROM DUAL UNION

  SELECT 'EDP', '11330', 'BASE' FROM DUAL UNION
  SELECT 'EDP', '11335', 'BASE' FROM DUAL UNION
  SELECT 'EDP', '11340', 'BASE' FROM DUAL UNION
  SELECT 'EDP', '11345', 'BASE' FROM DUAL UNION

  SELECT 'EDPEL', '11330', 'BASE' FROM DUAL UNION
  SELECT 'EDPEL', '11335', 'BASE' FROM DUAL UNION
  SELECT 'EDPEL', '11340', 'BASE' FROM DUAL UNION
  SELECT 'EDPEL', '11345', 'BASE' FROM DUAL UNION

  SELECT 'EDP', '11410', 'BASE' FROM DUAL;


  CURSOR C2 IS  
  SELECT 'EDP' AS COD_CONTRATTO, '11010' AS COD_VOCE, 'BASE' AS COD_VOCE_SPECIALE FROM DUAL UNION
  SELECT 'EDP', '11010', 'ENTE' FROM DUAL UNION

  SELECT 'EDPEL', '11010' AS COD_VOCE, 'BASE' AS COD_VOCE_SPECIALE FROM DUAL UNION
  SELECT 'EDPEL', '11010', 'ENTE' FROM DUAL UNION

  SELECT 'EDP', '11020', 'BASE' FROM DUAL UNION
  SELECT 'EDP', '11020', 'ENTE' FROM DUAL;


  CURSOR C3 IS  
  SELECT 'EDP' AS COD_CONTRATTO, '11017' AS COD_VOCE, 'BASE' AS COD_VOCE_SPECIALE FROM DUAL UNION
  
  SELECT 'EDPEL', '11017' AS COD_VOCE, 'BASE' AS COD_VOCE_SPECIALE FROM DUAL UNION
  
  SELECT 'EDP', '11027', 'BASE' FROM DUAL;  


  CURSOR C4 IS  
  SELECT 'EDP' AS COD_CONTRATTO, '11410' AS COD_VOCE, 'BASE' AS COD_VOCE_SPECIALE FROM DUAL;  

begin
  -- IMPOSTARE QUI IL NUOVO ANNO DA GESTIRE
  AnnoNuovo:=2015;
  
select COUNT(*) into i from P232_SCAGLIONI T
WHERE T.COD_CONTRATTO IN('EDP','EDPEL') AND T.COD_VOCE='11010' AND T.COD_VOCE_SPECIALE='BASE'
AND T.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo-1),'DDMMYYYY') AND NOT EXISTS
(select 'X' from P232_SCAGLIONI V
WHERE V.COD_CONTRATTO=T.COD_CONTRATTO AND V.COD_VOCE='11010' AND V.COD_VOCE_SPECIALE='BASE'
AND V.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));

if i > 0 then

  FOR T1 IN C1 LOOP
    CodContratto:=T1.COD_CONTRATTO;
    CodVoce:=T1.COD_VOCE;
    CodVoceSpeciale:=T1.COD_VOCE_SPECIALE;
    
    SELECT P233_ID_SCAGLIONE.NEXTVAL INTO ID_P233 FROM DUAL;
   
    INSERT INTO P232_SCAGLIONI
    SELECT COD_CONTRATTO, COD_VOCE, COD_VOCE_SPECIALE, TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'), ID_P233, TIPO_IMPORTO, TIPO_RITENUTA, TIPO_APPLICAZIONE,
           CONGUAGLIO_ANNUALE, CONGUAGLIO_FINE_RAPPORTO, CONGUAGLIO_DOPO_FINE_RAPPORTO, COD_VOCE_CONGUAGLIO, COD_VOCE_SPECIALE_CONGUAGLIO, MENSILITA_ANNUE,
           MASSIMALE1, MASSIMALE2, COD_VOCE_PESO1, COD_VOCE_SPECIALE_PESO1, COD_VOCE_PESO2, COD_VOCE_SPECIALE_PESO2, COD_VOCE_CONGUAGLIO2, COD_VOCE_SPECIALE_CONGUAGLIO2 FROM P232_SCAGLIONI P232 
    WHERE P232.COD_CONTRATTO=CodContratto AND P232.COD_VOCE=CodVoce AND P232.COD_VOCE_SPECIALE=CodVoceSpeciale AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo-1),'DDMMYYYY');
  
    INSERT INTO P233_SCAGLIONIFASCE
    SELECT ID_P233, IMPORTO_DA, IMPORTO_A, PERC_IMP FROM P233_SCAGLIONIFASCE P233,P232_SCAGLIONI P232 WHERE P233.ID_SCAGLIONE=P232.ID_SCAGLIONE
    AND P232.COD_CONTRATTO=CodContratto AND P232.COD_VOCE=CodVoce AND P232.COD_VOCE_SPECIALE=CodVoceSpeciale AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo-1),'DDMMYYYY');
  END LOOP;
  
  -- IMPOSTARE QUI LE NUOVE PERCENTUALI PER I DIPENDENTI CPDEL, CPS E ENPAM EX CONVENZIONATI
  PercDipCP_Fis:=8.85;
  PercDipCP_Agg:=1;
  -- IMPOSTARE QUI LE NUOVE PERCENTUALI PER I DIPENDENTI INPGI
  PercDipGI_1:=8.69;
  PercDipGI_2:=9.69;
  -- IMPOSTARE QUI LE NUOVE PERCENTUALI PER I DIPENDENTI OPTANTI INPS
  PercDipIN_1:=9.19;
  PercDipIN_2:=10.19;
  -- IMPOSTARE QUI LE NUOVE PERCENTUALI PER I DIPENDENTI PERSONALE RELIGIOSO INPS
  PercDipINRel_1:=8.84;
  PercDipINRel_2:=9.84;
  -- IMPOSTARE QUI LE NUOVE PERCENTUALI PER I PARASUBORDINATI CON COPERTURE ASSICURATIVE E ENPAPI CON COPERTURE ASSICURATIVE O PENSIONATI ANZIANITA’
  PercDip11110:=7.833333;
  PercEnte11115:=15.666667;
  -- IMPOSTARE QUI LE NUOVE PERCENTUALI PER I PARASUBORDINATI E ENPAPI SENZA COPERTURE ASSICURATIVE
  PercDip11120:=10.24;
  PercEnte11125:=20.48;
  -- IMPOSTARE QUI LE NUOVE PERCENTUALI PER I PARASUBORDINATI PENSIONATI ANZIANITA’
  PercDip11130:=7.833333;
  PercEnte11135:=15.666667;

  FOR T2 IN C2 LOOP
    -- CPDEL, CPS quota fissa
    UPDATE P233_SCAGLIONIFASCE P233 SET PERC_IMP=PercDipCP_Fis WHERE
    P233.ID_SCAGLIONE=
    (SELECT P232.ID_SCAGLIONE FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO=T2.COD_CONTRATTO AND P232.COD_VOCE=T2.COD_VOCE AND P232.COD_VOCE_SPECIALE=T2.COD_VOCE_SPECIALE AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));
  END LOOP;

  FOR T3 IN C3 LOOP
    -- CPDEL, CPS quota aggiuntiva
    UPDATE P233_SCAGLIONIFASCE P233 SET PERC_IMP=PercDipCP_Agg WHERE P233.IMPORTO_A=0
    AND P233.ID_SCAGLIONE=
    (SELECT P232.ID_SCAGLIONE FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO=T3.COD_CONTRATTO AND P232.COD_VOCE=T3.COD_VOCE AND P232.COD_VOCE_SPECIALE=T3.COD_VOCE_SPECIALE AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));
  END LOOP;

  FOR T4 IN C4 LOOP
    -- ENPAM EX CONVENZIONATI
    UPDATE P233_SCAGLIONIFASCE P233 SET PERC_IMP=PercDipCP_Fis WHERE P233.IMPORTO_DA=0
    AND P233.ID_SCAGLIONE=
    (SELECT P232.ID_SCAGLIONE FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO=T4.COD_CONTRATTO AND P232.COD_VOCE=T4.COD_VOCE AND P232.COD_VOCE_SPECIALE=T4.COD_VOCE_SPECIALE AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));

    UPDATE P233_SCAGLIONIFASCE P233 SET PERC_IMP=PercDipCP_Fis + PercDipCP_Agg WHERE P233.IMPORTO_A=0
    AND P233.ID_SCAGLIONE=
    (SELECT P232.ID_SCAGLIONE FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO=T4.COD_CONTRATTO AND P232.COD_VOCE=T4.COD_VOCE AND P232.COD_VOCE_SPECIALE=T4.COD_VOCE_SPECIALE AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));
  END LOOP;

-- INPGI
  UPDATE P233_SCAGLIONIFASCE P233 SET PERC_IMP=PercDipGI_1 WHERE P233.IMPORTO_DA=0
  AND P233.ID_SCAGLIONE IN
  (SELECT P232.ID_SCAGLIONE FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO IN('EDP','EDPEL') AND P232.COD_VOCE='11090' AND P232.COD_VOCE_SPECIALE='BASE' AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));

  UPDATE P233_SCAGLIONIFASCE P233 SET PERC_IMP=PercDipGI_2 WHERE P233.IMPORTO_A=0
  AND P233.ID_SCAGLIONE IN
  (SELECT P232.ID_SCAGLIONE FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO IN('EDP','EDPEL') AND P232.COD_VOCE='11090' AND P232.COD_VOCE_SPECIALE='BASE' AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));
  
-- OPTANTI INPS
  UPDATE P233_SCAGLIONIFASCE P233 SET PERC_IMP=PercDipIN_1 WHERE P233.IMPORTO_DA=0
  AND P233.ID_SCAGLIONE IN
  (SELECT P232.ID_SCAGLIONE FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO IN('EDP','EDPEL') AND P232.COD_VOCE='11160' AND P232.COD_VOCE_SPECIALE='BASE' AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));

  UPDATE P233_SCAGLIONIFASCE P233 SET PERC_IMP=PercDipIN_2 WHERE P233.IMPORTO_A=0
  AND P233.ID_SCAGLIONE IN
  (SELECT P232.ID_SCAGLIONE FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO IN('EDP','EDPEL') AND P232.COD_VOCE='11160' AND P232.COD_VOCE_SPECIALE='BASE' AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));
  
-- PERSONALE RELIGIOSO INPS
  UPDATE P233_SCAGLIONIFASCE P233 SET PERC_IMP=PercDipINRel_1 WHERE P233.IMPORTO_DA=0
  AND P233.ID_SCAGLIONE IN
  (SELECT P232.ID_SCAGLIONE FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO IN('EDP','EDPEL') AND P232.COD_VOCE='11170' AND P232.COD_VOCE_SPECIALE='BASE' AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));

  UPDATE P233_SCAGLIONIFASCE P233 SET PERC_IMP=PercDipINRel_2 WHERE P233.IMPORTO_A=0
  AND P233.ID_SCAGLIONE IN
  (SELECT P232.ID_SCAGLIONE FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO IN('EDP','EDPEL') AND P232.COD_VOCE='11170' AND P232.COD_VOCE_SPECIALE='BASE' AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));
  
-- INPS con coperture assicurative e ENPAPI con coperture assicurative o pensionati anzianita’
  UPDATE P233_SCAGLIONIFASCE P233 SET PERC_IMP=PercDip11110 WHERE P233.IMPORTO_DA=0
  AND P233.ID_SCAGLIONE IN
  (SELECT P232.ID_SCAGLIONE FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO IN('EDP','EDPEL') AND P232.COD_VOCE IN('11110','11330') AND P232.COD_VOCE_SPECIALE='BASE' AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));

  UPDATE P233_SCAGLIONIFASCE P233 SET PERC_IMP=PercEnte11115 WHERE P233.IMPORTO_DA=0
  AND P233.ID_SCAGLIONE IN
  (SELECT P232.ID_SCAGLIONE FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO IN('EDP','EDPEL') AND P232.COD_VOCE IN('11115','11335') AND P232.COD_VOCE_SPECIALE='BASE' AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));

-- INPS e ENPAPI no coperture assicurative
  UPDATE P233_SCAGLIONIFASCE P233 SET PERC_IMP=PercDip11120 WHERE P233.IMPORTO_DA=0
  AND P233.ID_SCAGLIONE IN
  (SELECT P232.ID_SCAGLIONE FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO IN('EDP','EDPEL') AND P232.COD_VOCE IN('11120','11340') AND P232.COD_VOCE_SPECIALE='BASE' AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));

  UPDATE P233_SCAGLIONIFASCE P233 SET PERC_IMP=PercEnte11125 WHERE P233.IMPORTO_DA=0
  AND P233.ID_SCAGLIONE IN
  (SELECT P232.ID_SCAGLIONE FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO IN('EDP','EDPEL') AND P232.COD_VOCE IN('11125','11345') AND P232.COD_VOCE_SPECIALE='BASE' AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));

-- INPS pensionati anzianita’
  UPDATE P233_SCAGLIONIFASCE P233 SET PERC_IMP=PercDip11130 WHERE P233.IMPORTO_DA=0
  AND P233.ID_SCAGLIONE IN
  (SELECT P232.ID_SCAGLIONE FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO IN('EDP','EDPEL') AND P232.COD_VOCE='11130' AND P232.COD_VOCE_SPECIALE='BASE' AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));

  UPDATE P233_SCAGLIONIFASCE P233 SET PERC_IMP=PercEnte11135 WHERE P233.IMPORTO_DA=0
  AND P233.ID_SCAGLIONE IN
  (SELECT P232.ID_SCAGLIONE FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO IN('EDP','EDPEL') AND P232.COD_VOCE='11135' AND P232.COD_VOCE_SPECIALE='BASE' AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));

end if;
end;

/

-- *********************************************************************************
-- IMPOSTAZIONE PROVVISORIA NUOVO SCAGLIONE PER INPGI
-- ****************  2015 ****************
-- *********************************************************************************

declare 
  AnnoNuovo integer;
  Scaglione real;

begin
  -- IMPOSTARE QUI IL NUOVO ANNO DA GESTIRE
  AnnoNuovo:=2015;
  -- IMPOSTARE QUI IL NUOVO SCAGLIONE PER MAGGIORAZIONE 1%
  Scaglione:=44766;

  UPDATE P233_SCAGLIONIFASCE P233 SET IMPORTO_A=Scaglione WHERE P233.IMPORTO_DA=0
  AND P233.ID_SCAGLIONE=
  (SELECT P232.ID_SCAGLIONE FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO IN('EDP','EDPEL') AND P232.COD_VOCE='11090' AND P232.COD_VOCE_SPECIALE='BASE' AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));

  UPDATE P233_SCAGLIONIFASCE P233 SET IMPORTO_DA=Scaglione+0.01 WHERE P233.IMPORTO_A=0
  AND P233.ID_SCAGLIONE=
  (SELECT P232.ID_SCAGLIONE FROM P232_SCAGLIONI P232 WHERE P232.COD_CONTRATTO IN('EDP','EDPEL') AND P232.COD_VOCE='11090' AND P232.COD_VOCE_SPECIALE='BASE' AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));
 
end;
/

-- *********************************************************************************
-- CREAZIONE NUOVE PERCENTUALI PER VOCI RELATIVE A CONVENZIONATI ENPAM
-- ****************  2015 (FATTO SU SQL PATCH) ****************
-- *********************************************************************************

declare 
  i integer;
  ID_P200 integer;
  IdVoceOld integer;
  AnnoNuovo integer;
  CodContratto varchar2(5);
  CodVoce varchar2(5);
  CodVoceSpeciale varchar2(5);
  PercDip11410 real;
  PercDip11420 real;
  PercDip11430 real;
  PercDip11440 real;

  CURSOR C1 IS  
  SELECT 'EDPSC' AS COD_CONTRATTO, '11410' AS COD_VOCE, 'BASE' AS COD_VOCE_SPECIALE FROM DUAL UNION
  SELECT 'EDPSC', '11420', 'BASE' FROM DUAL UNION
  SELECT 'EDPSC', '11430', 'BASE' FROM DUAL UNION
  SELECT 'EDPSC', '11440', 'BASE' FROM DUAL;

begin
  -- IMPOSTARE QUI IL NUOVO ANNO DA GESTIRE
  AnnoNuovo:=2015;
  -- IMPOSTARE QUI LE NUOVE PERCENTUALI PER I DIPENDENTI CONVENZIONATI ENPAM
  PercDip11410:=6.625;
  PercDip11420:=6.625;
  PercDip11430:=10.81;
  PercDip11440:=11.34;
  
select COUNT(*) into i from P200_VOCI T
WHERE T.COD_CONTRATTO = 'EDPSC' AND T.COD_VOCE IN('11410','11420','11430','11440') AND T.COD_VOCE_SPECIALE='BASE'
AND NOT EXISTS
(select 'X' from P200_VOCI V
WHERE V.COD_CONTRATTO=T.COD_CONTRATTO AND T.COD_VOCE IN('11410','11420','11430','11440') AND V.COD_VOCE_SPECIALE=T.COD_VOCE_SPECIALE
AND V.DECORRENZA>=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'));
 
if i > 0 then

  FOR T1 IN C1 LOOP
    CodContratto:=T1.COD_CONTRATTO;
    CodVoce:=T1.COD_VOCE;
    CodVoceSpeciale:=T1.COD_VOCE_SPECIALE;
    
    SELECT T.ID_VOCE INTO IdVoceOld FROM P200_VOCI T
      WHERE T.COD_CONTRATTO=CodContratto AND T.COD_VOCE=CodVoce AND T.COD_VOCE_SPECIALE=CodVoceSpeciale
      AND TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY')-1 BETWEEN T.DECORRENZA AND T.DECORRENZA_FINE;
    
    SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
    
    insert into p200_voci
    select cod_contratto, cod_voce, cod_voce_speciale, TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY'), ID_P200, descrizione, cod_voce_stampa, descrizione_stampa, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario, importo_massimo from p200_voci t
      WHERE T.ID_VOCE=IdVoceOld;

    UPDATE p200_voci t SET T.DECORRENZA_FINE=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY')-1
      WHERE T.ID_VOCE=IdVoceOld;

  END LOOP;
  
  UPDATE P200_VOCI T SET T.RITENUTA_PERC=PercDip11410
    WHERE T.COD_CONTRATTO='EDPSC' AND T.COD_VOCE='11410' AND T.COD_VOCE_SPECIALE='BASE'
    AND TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY') BETWEEN T.DECORRENZA AND T.DECORRENZA_FINE;

  UPDATE P200_VOCI T SET T.RITENUTA_PERC=PercDip11420
    WHERE T.COD_CONTRATTO='EDPSC' AND T.COD_VOCE='11420' AND T.COD_VOCE_SPECIALE='BASE'
    AND TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY') BETWEEN T.DECORRENZA AND T.DECORRENZA_FINE;

  UPDATE P200_VOCI T SET T.RITENUTA_PERC=PercDip11430
    WHERE T.COD_CONTRATTO='EDPSC' AND T.COD_VOCE='11430' AND T.COD_VOCE_SPECIALE='BASE'
    AND TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY') BETWEEN T.DECORRENZA AND T.DECORRENZA_FINE;

  UPDATE P200_VOCI T SET T.RITENUTA_PERC=PercDip11440
    WHERE T.COD_CONTRATTO='EDPSC' AND T.COD_VOCE='11440' AND T.COD_VOCE_SPECIALE='BASE'
    AND TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY') BETWEEN T.DECORRENZA AND T.DECORRENZA_FINE;

end if;
end;

/

-- Addizionale regionale Emilia Romagna 2015

declare 
  i integer;

begin
select COUNT(*) into i from P044_ENTIIRPEFFASCE where ANNO=2015 and TIPO_ADDIZIONALE='R' and COD_ENTE='06';

if i > 0 then
  update P042_ENTIIRPEF set RITENUTA_PROGRESSIVA_SCAGLIONI='S'
    where ANNO=2015 and TIPO_ADDIZIONALE='R' and COD_ENTE='06';
 
  delete P044_ENTIIRPEFFASCE where ANNO=2015 and TIPO_ADDIZIONALE='R' and COD_ENTE='06';

  insert into P044_ENTIIRPEFFASCE (anno, tipo_addizionale, cod_ente, importo_da, importo_a, perc)
  values (2015, 'R', '06', 0, 15000, 1.33);
  insert into P044_ENTIIRPEFFASCE (anno, tipo_addizionale, cod_ente, importo_da, importo_a, perc)
  values (2015, 'R', '06', 15000.01, 28000, 1.93);
  insert into P044_ENTIIRPEFFASCE (anno, tipo_addizionale, cod_ente, importo_da, importo_a, perc)
  values (2015, 'R', '06', 28000.01, 55000, 2.03);
  insert into P044_ENTIIRPEFFASCE (anno, tipo_addizionale, cod_ente, importo_da, importo_a, perc)
	values (2015, 'R', '06', 55000.01, 75000, 2.23);
	insert into P044_ENTIIRPEFFASCE (anno, tipo_addizionale, cod_ente, importo_da, importo_a, perc)
	values (2015, 'R', '06', 75000.01, 0, 2.33);

end if;

end;
/
