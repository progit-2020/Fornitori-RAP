CREATE OR REPLACE PROCEDURE CREAZIONE_STORICO_FAMILIARI
  (NI IN NUMBER, NORD IN NUMBER, DAL IN OUT DATE, P_AL IN DATE)
AS
  P INTEGER;
  FINEDEC DATE;
  DECOR DATE;
  NUOVODAL DATE;
  DATAMIN DATE;
  AL DATE;
BEGIN
  AL:=P_AL;
  IF DAL > TO_DATE('31/12/3999','dd/mm/yyyy') THEN
    RETURN;
  END IF;
  IF DAL IS NULL THEN
    SELECT MIN(DECORRENZA) INTO DAL FROM SG101_FAMILIARI WHERE PROGRESSIVO = NI AND NUMORD = NORD;
  END IF;
  NUOVODAL:=DAL;
  /*Se il movimento storico inizia in corso di mese e non ci sono movimenti storici precedenti,
    forzo la decorrenza all'inizio del mese*/
--  IF TO_CHAR(NUOVODAL,'DD') <> '01' THEN
--    SELECT COUNT(*) INTO P FROM SG101_FAMILIARI WHERE
--      PROGRESSIVO = NI AND NUMORD = NORD AND DECORRENZA < NUOVODAL;
--    IF P = 0 THEN
--      NUOVODAL:=TO_DATE(TO_CHAR(NUOVODAL,'/mm/yyyy'),'/mm/yyyy');
--    END IF;
--  END IF;
  IF AL >= TO_DATE('31/12/3999','dd/mm/yyyy') THEN
    AL:=NULL;
  END IF;
  IF (AL IS NULL) OR (P = 0) THEN
    FINEDEC:=TO_DATE('31/12/3999','dd/mm/yyyy');
  ELSE
    FINEDEC:=AL;
  END IF;
  SELECT COUNT(*) INTO P FROM SG101_FAMILIARI WHERE PROGRESSIVO = NI AND NUMORD = NORD
    AND NUOVODAL BETWEEN DECORRENZA AND DECORRENZA_FINE;
  IF P = 0 THEN
    /*gestione del caso in cui si inserisce un movimento storico prima di quelli gi inseriti*/
    SELECT MIN(DECORRENZA) INTO DATAMIN FROM SG101_FAMILIARI WHERE PROGRESSIVO = NI AND NUMORD = NORD;
    IF DATAMIN IS NOT NULL AND DATAMIN > NUOVODAL THEN
      FINEDEC:=DATAMIN - 1;
    END IF;
    /*Creazione storico nuovo, da completare con valori di default*/
    DELETE FROM SG101_APPOGGIO;
    INSERT INTO SG101_APPOGGIO
      SELECT * FROM SG101_FAMILIARI
       WHERE PROGRESSIVO = NI AND NUMORD = NORD
         AND DECORRENZA = (SELECT MIN(DECORRENZA) FROM SG101_FAMILIARI WHERE PROGRESSIVO = NI AND NUMORD = NORD);
    UPDATE SG101_APPOGGIO SET DECORRENZA = NUOVODAL,DECORRENZA_FINE = FINEDEC WHERE PROGRESSIVO = NI AND NUMORD = NORD;
    INSERT INTO SG101_FAMILIARI SELECT * FROM SG101_APPOGGIO WHERE PROGRESSIVO = NI AND NUMORD = NORD;
    IF SQL%ROWCOUNT = 0 THEN
      INSERT INTO SG101_FAMILIARI
      (PROGRESSIVO,NUMORD,DECORRENZA,DECORRENZA_FINE)
      VALUES
      (NI,NORD,NUOVODAL,FINEDEC);
    END IF;
    DELETE FROM SG101_APPOGGIO;
  ELSE
    /*Verifico se esiste una situazione storica con datadecorrenza = DAL*/
    SELECT COUNT(*) INTO P FROM SG101_FAMILIARI WHERE PROGRESSIVO = NI AND NUMORD = NORD
      AND DECORRENZA = NUOVODAL;
    IF P = 0 THEN
      DELETE FROM SG101_APPOGGIO;
      INSERT INTO SG101_APPOGGIO
        SELECT * FROM SG101_FAMILIARI WHERE PROGRESSIVO = NI AND NUMORD = NORD
          AND NUOVODAL BETWEEN DECORRENZA AND DECORRENZA_FINE;
      SELECT DECORRENZA INTO DECOR FROM SG101_APPOGGIO WHERE PROGRESSIVO = NI AND NUMORD = NORD;
      UPDATE SG101_APPOGGIO SET DECORRENZA = NUOVODAL WHERE PROGRESSIVO = NI AND NUMORD = NORD;
      INSERT INTO SG101_FAMILIARI SELECT * FROM SG101_APPOGGIO WHERE PROGRESSIVO = NI AND NUMORD = NORD;
      UPDATE SG101_FAMILIARI SET DECORRENZA_FINE = NUOVODAL - 1 WHERE PROGRESSIVO = NI AND NUMORD = NORD
             AND DECORRENZA = DECOR;
      DELETE FROM SG101_APPOGGIO;
    END IF;
  END IF;
  IF AL IS NOT NULL THEN
    /*Verifico se esiste una situazione storica con datadecorrenza = AL + 1*/
    SELECT COUNT(*) INTO P FROM SG101_FAMILIARI WHERE PROGRESSIVO = NI AND NUMORD = NORD AND DECORRENZA = AL + 1;
    IF P = 0 THEN
      DELETE FROM SG101_APPOGGIO;
      INSERT INTO SG101_APPOGGIO
        SELECT * FROM SG101_FAMILIARI WHERE PROGRESSIVO = NI AND NUMORD = NORD
          AND AL BETWEEN DECORRENZA AND DECORRENZA_FINE;
      SELECT DECORRENZA INTO DECOR FROM SG101_APPOGGIO WHERE PROGRESSIVO = NI AND NUMORD = NORD;
      UPDATE SG101_APPOGGIO SET DECORRENZA = AL  + 1 WHERE PROGRESSIVO = NI AND NUMORD = NORD;
      INSERT INTO SG101_FAMILIARI SELECT * FROM SG101_APPOGGIO WHERE PROGRESSIVO = NI AND NUMORD = NORD;
      UPDATE SG101_FAMILIARI SET DECORRENZA_FINE = AL WHERE PROGRESSIVO = NI AND NUMORD = NORD AND DECORRENZA = DECOR;
      DELETE FROM SG101_APPOGGIO;
    END IF;
  END IF;
END;
/