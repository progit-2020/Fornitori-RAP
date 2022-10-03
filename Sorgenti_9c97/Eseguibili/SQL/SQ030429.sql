UPDATE MONDOEDP.I090_ENTI SET VERSIONEDB = '5.5.0' WHERE AZIENDA = :AZIENDA;

SELECT * FROM T800_CAMPILIMITI ORDER BY TIPOLIMITE,DATADECORR;

-- Cambia valori al tipo limite mensile e sposta parametri da T800 a T025
UPDATE T800_CAMPILIMITI SET TIPOLIMITE = 'L'  WHERE TIPOLIMITE = '0';
UPDATE T800_CAMPILIMITI SET TIPOLIMITE = 'R'  WHERE TIPOLIMITE = '1';

ALTER TABLE T025_CONTMENSILI ADD  LIMITE_MM_ECCLIQ_TIPO VARCHAR2(2) DEFAULT 'CL';
ALTER TABLE T025_CONTMENSILI ADD  LIMITE_MM_ECCLIQ_DEFAULT VARCHAR2(1) DEFAULT 'N';
ALTER TABLE T025_CONTMENSILI ADD  LIMITE_MM_ECCRES_TIPO VARCHAR2(2) DEFAULT 'CL';
ALTER TABLE T025_CONTMENSILI ADD  LIMITE_MM_ECCRES_DEFAULT VARCHAR2(1) DEFAULT 'N';
ALTER TABLE T025_CONTMENSILI ADD  TRASF_SUPERO_LIQANN VARCHAR2(1) DEFAULT 'N';

DECLARE
  TR_ECC_OLD VARCHAR2(1);
  BEGIN 
    --Limite liquidabile
    BEGIN
      SELECT TRONCA_ECCEDENZE INTO TR_ECC_OLD FROM T800_CAMPILIMITI 
        WHERE TIPOLIMITE = 'L' AND DATADECORR = (SELECT MAX(DATADECORR) 
        FROM T800_CAMPILIMITI WHERE TIPOLIMITE = 'L');
      --Se c'� struttura decodifico valori e forzo limite a zero
      UPDATE T025_CONTMENSILI SET LIMITE_MM_ECCLIQ_TIPO = DECODE(TR_ECC_OLD,'N','CL','S','LM','LM'),
        LIMITE_MM_ECCLIQ_DEFAULT = 'Z';
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        --Se non c'� struttura forzo DEFAULT 'LM' e nessun limite
        UPDATE T025_CONTMENSILI SET LIMITE_MM_ECCLIQ_TIPO = 'LM',
          LIMITE_MM_ECCLIQ_DEFAULT = 'N';
    END;
    --Limite residuabile
    BEGIN
      SELECT TRONCA_ECCEDENZE INTO TR_ECC_OLD FROM T800_CAMPILIMITI 
        WHERE TIPOLIMITE = 'R' AND DATADECORR = (SELECT MAX(DATADECORR) 
        FROM T800_CAMPILIMITI WHERE TIPOLIMITE = 'R');
      --Se c'� struttura decodifico valori e forzo limite a zero
      UPDATE T025_CONTMENSILI SET LIMITE_MM_ECCRES_TIPO = DECODE(TR_ECC_OLD,'S','CL','L','LL','CL'),
        LIMITE_MM_ECCRES_DEFAULT = 'Z';
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        --Se non c'� struttura forzo DEFAULT 'CL' e nessun limite
        UPDATE T025_CONTMENSILI SET LIMITE_MM_ECCRES_TIPO = 'CL',
          LIMITE_MM_ECCRES_DEFAULT = 'N';
    END;
  END;
/

-- AGGIUNTA COLONNA NELLA TABELLA DI PARANETRIZZAZIONE DEI FLUSSI STATISTICI
ALTER TABLE T931_TRACCIATOESTRAZIONISTAMPE ADD VALORE_NULL VARCHAR2(1);
ALTER TABLE T931_TRACCIATOESTRAZIONISTAMPE ADD FORMATO VARCHAR2(20);
ALTER TABLE T931_TRACCIATOESTRAZIONISTAMPE ADD SOMMA_RICORRENZE VARCHAR2(25);
UPDATE T931_TRACCIATOESTRAZIONISTAMPE SET SOMMA_RICORRENZE = 'NON SOMMARE' WHERE SOMMA_RICORRENZE IS NULL;
ALTER TABLE T930_PARESTRAZIONISTAMPE ADD UTENTI_PRIVILEGI VARCHAR2(50);

ALTER TABLE T670_REGOLEBUONI MODIFY ASSENZA VARCHAR2(600);

ALTER TABLE T020_ORARI ADD ORAMAX_COMPENSABILE VARCHAR2(5);

ALTER TABLE T025_CONTMENSILI ADD SOGLIA_COMP_LIQ VARCHAR2(7) DEFAULT '-01.00';
