alter table MONDOEDP.I061_PROFILI_DIPENDENTE add ULTIMO_ACCESSO date;
alter table MONDOEDP.I061_PROFILI_DIPENDENTE add ULTIMO_INVIO_MAIL date; 

ALTER TABLE SG730_PUNTEGGI ADD CODICE VARCHAR2(5);
UPDATE SG730_PUNTEGGI
SET CODICE = TO_CHAR(PUNTEGGIO)
WHERE CODICE IS NULL;
ALTER TABLE SG730_PUNTEGGI MODIFY CODICE NOT NULL;
alter table SG730_PUNTEGGI drop primary key/*--NOLOG--*/;
drop index SG730_PK/*--NOLOG--*/;
alter table SG730_PUNTEGGI
  add constraint SG730_PK primary key (DATO1,DECORRENZA,CODICE) 
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
ALTER TABLE SG711_VALUTAZIONI_DIPENDENTE ADD COD_PUNTEGGIO VARCHAR2(5);
UPDATE SG711_VALUTAZIONI_DIPENDENTE
SET COD_PUNTEGGIO = TO_CHAR(PUNTEGGIO)
WHERE COD_PUNTEGGIO IS NULL;

ALTER TABLE SG710_TESTATA_VALUTAZIONI ADD ACCETTAZIONE_VALUTATO VARCHAR2(1) DEFAULT 'S';
ALTER TABLE SG710_TESTATA_VALUTAZIONI ADD PROPOSTE_FORMATIVE_1 VARCHAR2(1);
ALTER TABLE SG710_TESTATA_VALUTAZIONI ADD PROPOSTE_FORMATIVE_2 VARCHAR2(1);
ALTER TABLE SG710_TESTATA_VALUTAZIONI ADD PROPOSTE_FORMATIVE_3 VARCHAR2(1);

-- **********************************************************************
-- MASSIMALE NUOVI ISCRITTI E DIRETTORI PER CPDEL, CPS, ENPAM EX CONVENZIONATI
-- ****************  2011 ****************
-- **********************************************************************

declare 
  AnnoNuovo integer;
  MassimaleIsc real;
  MassimaleDir real;

  CURSOR C1 IS  
  SELECT '11010' AS COD_VOCE, 'BASE' AS COD_VOCE_SPECIALE FROM DUAL UNION
  SELECT '11020', 'BASE' FROM DUAL UNION
  SELECT '11410', 'BASE' FROM DUAL;
begin
  -- IMPOSTARE QUI IL NUOVO ANNO DA GESTIRE
  AnnoNuovo:=2011;
  -- IMPOSTARE QUI I NUOVI MASSIMALI NUOVI ISCRITTI E DIRETTORI
  MassimaleIsc:=93621.38;
  MassimaleDir:=170656.92;

  FOR T1 IN C1 LOOP
    
    UPDATE P232_SCAGLIONI P232 SET MASSIMALE1=MassimaleIsc, MASSIMALE2=MassimaleDir WHERE P232.COD_CONTRATTO='EDP' AND P232.COD_VOCE=T1.COD_VOCE AND P232.COD_VOCE_SPECIALE=T1.COD_VOCE_SPECIALE AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY');

  END LOOP;
 
end;
/

-- **********************************************************************
-- CREAZIONE VOCE EDP 11510 BASE
-- **********************************************************************

declare
  i integer;
  ID_P200 integer;
  CodVoceModello varchar2(5);
  CodVoceCopia varchar2(5);
  DesVoceCopia varchar2(40);
  DesVoceCopiaSt varchar2(40);
  CodVoceFiglio varchar2(5);
begin
  select COUNT(*) into i from P200_VOCI t WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE='11225' AND T.COD_VOCE_SPECIALE='BASE';
  if i > 0 then
    select COUNT(*) into i from P200_VOCI t WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE='11510' AND T.COD_VOCE_SPECIALE='BASE';
    if i = 0 then
  
      CodVoceModello:='11225';
      CodVoceCopia:='11510';
      DesVoceCopia:='Riduzione legge 122/2010 art. 9 c. 2';
      DesVoceCopiaSt:='Riduzione legge 122/2010 art. 9 c. 2';

      SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
      insert into p200_voci
      select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ',
      DesVoceCopia, protetta, tipo, rid_mese_ass_cess, 'CM', voce_importo, importo_automatico,
      importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni,
      ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile,
      stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert,
      ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam,
      abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note,
      'P', cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp,
      abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg,
      retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
      WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

      INSERT INTO P201_ASSOGGETTAMENTI
      select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
      where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

      INSERT INTO P201_ASSOGGETTAMENTI
      select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, '10200', cod_voce_speciale_figlio, decorrenza, -100, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
      where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceCopia and t.cod_voce_speciale_padre='BASE'
      and t.cod_voce_figlio='12960' and t.cod_voce_speciale_figlio='BASE';

    end if;
  end if;
end;
/

-- **********************************************************************
-- ACCORPAMENTO CU770 LEGGE122DEL2010
-- Riduzione legge 122/2010 art. 9 c. 2
-- **********************************************************************

UPDATE P214_TIPOACCORPAMENTOVOCI P214 SET P214.DESCRIZIONE='Accorpamenti CUD, 770 e normative varie'
WHERE P214.COD_TIPOACCORPAMENTOVOCI='CU770';

declare
  i integer;

begin
  select COUNT(*) into i from P442_CEDOLINOVOCI T WHERE T.COD_CONTRATTO='EDP';
  if i > 0 then
    select COUNT(*) into i from P215_CODICIACCORPAMENTOVOCI T WHERE T.COD_TIPOACCORPAMENTOVOCI='CU770' AND T.COD_CODICIACCORPAMENTOVOCI='LEGGE122DEL2010';
    if i = 0 then

      INSERT INTO P215_CODICIACCORPAMENTOVOCI SELECT 'CU770','LEGGE122DEL2010','Riduzione legge 122/2010 art. 9 c. 2' FROM DUAL;

      INSERT INTO P216_ACCORPAMENTOVOCI
      SELECT DISTINCT P200.COD_CONTRATTO, P200.COD_VOCE, P200.COD_VOCE_SPECIALE, 'CU770', 'LEGGE122DEL2010',
                      TO_DATE('01011900','DDMMYYYY'), 100, 'C', TO_DATE('31123999','DDMMYYYY')
      FROM P240_TIPIASSOGGETTAMENTI P240, P242_TIPIASSOGGETTAMENTIVOCI P242, P200_VOCI P200
      WHERE P240.ID_TIPOASSOGGETTAMENTO=P242.ID_TIPOASSOGGETTAMENTO 
      AND P200.COD_CONTRATTO=P240.COD_CONTRATTO AND P200.COD_VOCE=P242.COD_VOCE
      AND P200.COD_VOCE_SPECIALE=P242.COD_VOCE_SPECIALE
      AND P240.COD_CONTRATTO='EDP' AND P242.COD_VOCE_SPECIALE='BASE'
      AND P200.COD_VOCE IN ('10010','10020','10090','10160','10170','10410');

    end if;
  end if;
end;
/

