DECLARE
  CURSOR C1 IS
    SELECT *
    FROM T065_RICHIESTESTRAORDINARI
    WHERE OREMINUTI(ORE_ECCEDENTI) = 0
    AND RESPONSABILE IS NULL;
BEGIN
  FOR R1 IN C1 LOOP
    --Autorizzazione automatica della richiesta a 0 ore
    UPDATE T065_RICHIESTESTRAORDINARI
    SET ORE_ECCED_AUTORIZ = ORE_ECCEDENTI,
        ORE_COMP_AUTORIZ = ORE_DACOMPENSARE,
        ORE_LIQ_AUTORIZ = ORE_DALIQUIDARE,
        STATO = 'S',
        RESPONSABILE = 'AUTORIZZAZIONE AUTOMATICA',
        DATA_AUTORIZZAZIONE = DATA_RICHIESTA,
        NOTE_AUTORIZ = 'AUTORIZZAZIONE AUTOMATICA: ZERO ORE RICHIESTE'
    WHERE PROGRESSIVO = R1.PROGRESSIVO
    AND DATA = R1.DATA
    AND ID_CONGUAGLIO = R1.ID_CONGUAGLIO;
    --Aggiornamento della scheda riepilogativa
    UPDATE T070_SCHEDARIEPIL
    SET ORECOMP_LIQUIDATE = DECODE(R1.TIPO,'C',R1.ORE_DALIQUIDARE,ORECOMP_LIQUIDATE),
        BANCAORE_LIQ_VAR = DECODE(R1.TIPO,'C','00.00',BANCAORE_LIQ_VAR)
    WHERE PROGRESSIVO = R1.PROGRESSIVO
    AND DATA = R1.DATA;
    --Aggiornamento dei limiti individuali
    UPDATE T820_LIMITIIND
    SET LIQUIDABILE = 'N',
        ORE = DECODE(R1.TIPO,'C',R1.ORE_ECCEDENTI,ORE)
    WHERE PROGRESSIVO = R1.PROGRESSIVO
    AND anno = TO_NUMBER(TO_CHAR(R1.DATA,'YYYY'))
    AND mese = TO_NUMBER(TO_CHAR(R1.DATA,'MM'))
    AND dal = 1
    AND causale = '* B';
    IF SQL%rowcount = 0 THEN
      INSERT INTO T820_LIMITIIND
       (PROGRESSIVO,
        ANNO,
        MESE,
        DAL,
        AL,
        CAUSALE,
        LIQUIDABILE,
        ORE_TEORICHE,
        ORE)
      VALUES
       (R1.PROGRESSIVO,
        TO_NUMBER(TO_CHAR(R1.DATA,'YYYY')),
        TO_NUMBER(TO_CHAR(R1.DATA,'MM')),
        1,
        TO_CHAR(LAST_DAY(R1.DATA),'DD'),
        '* B',
        'N',
        NULL,
        R1.ORE_ECCEDENTI);
    END IF;
  END LOOP;
END;
/

-- Causale versamento IRPEF 143E

insert into p080_causaliirpef
  (cod_causaleirpef, descrizione)
values
  ('F24143E', 'Imposta sostitutiva dell''Irpef e delle addizionali regionali e comunali sui compensi accessori del reddito da lavoro dipendente a seguito di assistenza fiscale - articolo 2, decreto legge 27  maggio 2008, n. 93');

-- Aggiornamento voci 11840 e 11845

UPDATE P200_VOCI T SET T.COD_CAUSALEIRPEF='F24143E'
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE IN ('11840','11845');

