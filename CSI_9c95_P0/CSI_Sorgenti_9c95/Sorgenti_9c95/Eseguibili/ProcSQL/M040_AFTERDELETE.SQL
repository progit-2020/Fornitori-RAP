CREATE OR REPLACE TRIGGER M040_AFTERDELETE 
  AFTER DELETE ON M040_MISSIONI
  FOR EACH ROW
BEGIN
  -- mantiene coerenza delle sottotabelle con la chiave di M040
  delete from M050_RIMBORSI
  where  PROGRESSIVO = :old.PROGRESSIVO 
  and    MESESCARICO = :old.MESESCARICO 
  and    MESECOMPETENZA = :old.MESECOMPETENZA 
  and    DATADA = :old.DATADA 
  and    ORADA = :old.ORADA;
    
  delete from M051_DETTAGLIORIMBORSO
  where  PROGRESSIVO = :old.PROGRESSIVO 
  and    MESESCARICO = :old.MESESCARICO 
  and    MESECOMPETENZA = :old.MESECOMPETENZA 
  and    DATADA = :old.DATADA 
  and    ORADA = :old.ORADA;

  delete from M052_INDENNITAKM
  where  PROGRESSIVO = :old.PROGRESSIVO 
  and    MESESCARICO = :old.MESESCARICO 
  and    MESECOMPETENZA = :old.MESECOMPETENZA 
  and    DATADA = :old.DATADA 
  and    ORADA = :old.ORADA;
END;
/
