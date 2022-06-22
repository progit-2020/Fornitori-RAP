--******************************  PIANTA ORGANICA ******************************
DELETE SG506_PIANTADISTRIBUZIONE WHERE ID_PADRE NOT IN (SELECT ID_RAMO FROM SG506_PIANTADISTRIBUZIONE) AND ID_PADRE <> 0;
alter table SG506_PIANTADISTRIBUZIONE add NUMERO_PERCENTUALE number(10,2);

DECLARE
  CURSOR C1 IS 
   select codice, pianta from t460_parttime where codice in
  (SELECT distinct valore_campo 
   from sg506_piantadistribuzione
   where nome_campo = 'PARTTIME');
BEGIN
  UPDATE sg506_piantadistribuzione SET NUMERO_PERCENTUALE = NUMERO_CALCOLATI;
  FOR T1 IN C1 LOOP
    UPDATE sg506_piantadistribuzione SET NUMERO_PERCENTUALE = ((NUMERO_CALCOLATI * T1.PIANTA)/100) WHERE NOME_CAMPO='PARTTIME' AND VALORE_CAMPO = T1.CODICE;
  END LOOP;
  COMMIT;
END;
/

DECLARE
  CURSOR C1 IS
  SELECT *
    from sg506_piantadistribuzione
   where numero_percentuale <> 0
   order by livello desc;
   nPercentuali number;
   nLivello number;
   i number;
BEGIN
  SELECT MAX(LIVELLO) INTO nLivello FROM SG506_PIANTADISTRIBUZIONE;
  IF nLivello > 0 THEN
    FOR i in 1..nLivello loop
      FOR T1 IN C1 LOOP
        BEGIN
          SELECT SUM(NUMERO_PERCENTUALE) INTO nPercentuali FROM SG506_PIANTADISTRIBUZIONE WHERE LIVELLO = t1.livello AND ID_PADRE = T1.ID_PADRE;
          UPDATE sg506_piantadistribuzione SET NUMERO_PERCENTUALE= nPercentuali WHERE ID_RAMO = T1.ID_PADRE;
        END;
      END LOOP;
      COMMIT;
    END LOOP;
  END IF;
END;
/
--****************************** FINE PIANTA ORGANICA ******************************