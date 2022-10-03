create or replace trigger T025_AFTERDELUPD after DELETE or UPDATE on T025_CONTMENSILI for each row
begin
  if deleting then
    --delete from T026_SALDIABBATTUTI where CODICE = :OLD.CODICE;
    delete from T027_SOGLIE_STR_INPUT where TIPOCARTELLINO = :OLD.CODICE;
    delete from T029_RIENTRI_OBBLIGATORI where CODICE = :OLD.CODICE;
  elsif updating then
    --update T026_SALDIABBATTUTI set CODICE = :NEW.CODICE where CODICE = :OLD.CODICE;
    update T027_SOGLIE_STR_INPUT set TIPOCARTELLINO = :NEW.CODICE where TIPOCARTELLINO = :OLD.CODICE;
    update T029_RIENTRI_OBBLIGATORI set CODICE = :NEW.CODICE where CODICE = :OLD.CODICE;
  end if;
end;
/
