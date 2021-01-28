create or replace trigger T350_BEFOREUPD
  before update on T350_REGREPERIB
  for each row when (OLD.TIPOLOGIA <> NEW.TIPOLOGIA and OLD.CODICE = NEW.CODICE)
declare
begin
  update T380_PIANIFREPERIB 
  set TIPOLOGIA = :NEW.TIPOLOGIA
  where TURNO1 = :NEW.CODICE
  and TURNO2 is null
  and TURNO3 is null;
exception
  when others then null;
end T350_BEFOREUPD;
/