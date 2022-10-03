create or replace trigger T162_AFTERDELUPD after DELETE or UPDATE on T162_INDENNITA for each row
begin
  if deleting then
    delete from T164_ASSOCIAZIONIINDENNITA where CODICE = :OLD.CODICE;
    delete from T165_LIMITI_INDORARIA_TESTA where CODICE = :OLD.CODICE;
    delete from T171_LIMITI  where CODICE = :OLD.CODICE;
  elsif updating then
    update T164_ASSOCIAZIONIINDENNITA set CODICE = :NEW.CODICE where CODICE = :OLD.CODICE;
    update T165_LIMITI_INDORARIA_TESTA set CODICE = :NEW.CODICE where CODICE = :OLD.CODICE;
    update T171_LIMITI  set CODICE = :NEW.CODICE where CODICE = :OLD.CODICE;
  end if;
end;
/
