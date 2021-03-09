UPDATE MONDOEDP.I090_ENTI SET VERSIONEDB = '5.5.3' WHERE AZIENDA = :AZIENDA;

UPDATE T021_FASCEORARI SET 
  MMFLEX = '00.00' 
WHERE 
  TIPO_FASCIA = 'PMT' AND
  CODICE||TO_CHAR(DECORRENZA,'DDMMYYYY') IN 
    (SELECT CODICE||TO_CHAR(DECORRENZA,'DDMMYYYY') FROM T020_ORARI 
     WHERE 
       TIPOORA = 'E' AND
       TIPOMENSA IN ('B','D','E','F'));

ALTER TABLE T670_REGOLEBUONI ADD RESIDUO_PRECEDENTE DATE;       

ALTER TABLE T275_CAUPRESENZE ADD SOGLIA_FASCE_OBBLFAC NUMBER(3);

-----------------------------------------------------------------------------------------
-- ALLINEAMENTO BASE DATI PIANTA ORGANICA CON QUANTO CONTENUTO NELLE SCRIPT SQ030708.SQL
-----------------------------------------------------------------------------------------
DROP INDEX T500_UK_ID_PIANTA;
