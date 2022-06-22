CREATE OR REPLACE TRIGGER M140_AFTERDEL
  AFTER DELETE ON M140_RICHIESTE_MISSIONI
  FOR EACH ROW
BEGIN
  -- mantiene coerenza tra missioni richieste via web e già effettivamente caricate
  delete T850_ITER_RICHIESTE where ITER = 'M140' and ID = :old.ID and STATO is null;
  if sql%rowcount > 0 then
    delete from M040_MISSIONI
    where  ID_MISSIONE = :old.ID;
  end if;
END;
/