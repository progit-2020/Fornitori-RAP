ALTER TABLE T130_RESIDANNOPREC MODIFY SALDOOREPO VARCHAR2(8);
ALTER TABLE T130_RESIDANNOPREC MODIFY ORECOMPENSABILI VARCHAR2(8);
ALTER TABLE T130_RESIDANNOPREC MODIFY CAUSASSENZACOMP VARCHAR2(8);
ALTER TABLE T130_RESIDANNOPREC MODIFY RIPOSICOMP VARCHAR2(8);
ALTER TABLE T130_RESIDANNOPREC MODIFY BANCA_ORE VARCHAR2(8);

ALTER TABLE T025_CONTMENSILI ADD BANCA_ORE_RESID_ANNOPREC VARCHAR2(1) DEFAULT 'S';
ALTER TABLE T265_CAUASSENZE MODIFY CODCAU2 VARCHAR2(100);

ALTER TABLE T910_RIEPILOGO ADD CDC_PERCENTUALIZZATI VARCHAR2(1) DEFAULT 'N';
ALTER TABLE T911_DATIRIEPILOGO ADD CDC_PERCENTUALIZZATI VARCHAR2(1) DEFAULT 'N';

-- FINO A QUI GIA' ESEGUITO AL SACCO

ALTER TABLE I150_PARSCARICOGIUST ADD MATRICOLA_NUMERICA VARCHAR2(1) DEFAULT 'N';

DECLARE
  CURSOR C1 IS 
  SELECT T040.DATANAS,T044.ROWID IDRIGA FROM T040_GIUSTIFICATIVI T040, T044_STORICOGIUSTIFICATIVI T044
  WHERE T040.PROGRESSIVO = T044.PROGRESSIVO AND T040.DATA = T044.DATA 
  AND T040.CAUSALE = T044.CAUSALE AND T040.TIPOGIUST = T044.TIPOGIUST 
  AND T044.DATANAS IS NOT NULL
  AND T040.DATANAS <> T044.DATANAS 
  AND EXISTS (SELECT '*' FROM SG101_FAMILIARI WHERE PROGRESSIVO = T040.PROGRESSIVO
  AND DATANAS = T040.DATANAS);
BEGIN
  FOR T1 IN C1 LOOP
    UPDATE T044_STORICOGIUSTIFICATIVI SET DATANAS = T1.DATANAS WHERE ROWID = T1.IDRIGA;
  END LOOP;
END;
/

DECLARE
  CURSOR C1 IS 
  SELECT T044.DATANAS,T040.ROWID IDRIGA FROM T040_GIUSTIFICATIVI T040, T044_STORICOGIUSTIFICATIVI T044
  WHERE T040.PROGRESSIVO = T044.PROGRESSIVO AND T040.DATA = T044.DATA 
  AND T040.CAUSALE = T044.CAUSALE AND T040.TIPOGIUST = T044.TIPOGIUST 
  AND T040.DATANAS IS NOT NULL
  AND T040.DATANAS <> T044.DATANAS 
  AND EXISTS (SELECT '*' FROM SG101_FAMILIARI WHERE PROGRESSIVO = T044.PROGRESSIVO
  AND DATANAS = T044.DATANAS);
BEGIN
  FOR T1 IN C1 LOOP
    UPDATE T040_GIUSTIFICATIVI SET DATANAS = T1.DATANAS WHERE ROWID = T1.IDRIGA;
  END LOOP;
END;
/

DECLARE
  CURSOR C1 IS 
  SELECT T040.DATANAS,T044.ROWID IDRIGA FROM T040_GIUSTIFICATIVI T040, T044_STORICOGIUSTIFICATIVI T044
  WHERE T040.PROGRESSIVO = T044.PROGRESSIVO AND T040.DATA = T044.DATA 
  AND T040.CAUSALE = T044.CAUSALE AND T040.TIPOGIUST = T044.TIPOGIUST 
  AND T044.DATANAS IS NOT NULL
  AND T040.DATANAS <> T044.DATANAS 
  AND EXISTS (SELECT '*' FROM SG101_FAMILIARI WHERE PROGRESSIVO = T040.PROGRESSIVO
  AND DATANAS = T040.DATANAS);
BEGIN
  FOR T1 IN C1 LOOP
    UPDATE T044_STORICOGIUSTIFICATIVI SET DATANAS = T1.DATANAS WHERE ROWID = T1.IDRIGA;
  END LOOP;
END;
/


ALTER TABLE T910_RIEPILOGO MODIFY TOTPARZIALI DEFAULT 'S';
ALTER TABLE T910_RIEPILOGO MODIFY TOTRIEPILOGO DEFAULT 'S';
ALTER TABLE T910_RIEPILOGO MODIFY TOTGENERALI DEFAULT 'N';

UPDATE T265_CAUASSENZE SET FRUIZCOMPETENZE_ARR = NULL;
ALTER TABLE T265_CAUASSENZE MODIFY FRUIZCOMPETENZE_ARR VARCHAR2(1) DEFAULT 'N';
UPDATE T265_CAUASSENZE SET FRUIZCOMPETENZE_ARR = 'N';
ALTER TABLE T265_CAUASSENZE ADD INTERSEZIONE_TIMBRATURE VARCHAR2(1) DEFAULT 'E';