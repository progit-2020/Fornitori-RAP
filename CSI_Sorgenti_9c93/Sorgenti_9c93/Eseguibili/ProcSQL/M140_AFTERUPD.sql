CREATE OR REPLACE TRIGGER M140_AFTERUPD
  AFTER UPDATE OF DATADA,DATAA,ORADA,ORAA ON M140_RICHIESTE_MISSIONI
  FOR EACH ROW
BEGIN
  -- mantiene coerenza tra missioni richieste via web e già effetivamente caricate
  update M040_MISSIONI
  set    DATADA = :new.DATADA,
         ORADA = :new.ORADA,
         DATAA = :new.DATAA,
         ORAA = :new.ORAA,
         TOTALEGG = :new.DATAA - :new.DATADA + 1,
         DURATA = minutiore(((:new.DATAA - :new.DATADA) * 24 * 60) + (oreminuti(:new.ORAA) - oreminuti(:new.ORADA)))
  where  ID_MISSIONE = :old.ID;
END;
/