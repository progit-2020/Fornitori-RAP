create or replace trigger T230_AFTERUPDINS
  after insert or update
  on T230_CAUASSENZE_PARSTO
  for each row
begin
	--mantiene allineati i dati sulla T265 con l'ultima decorrenza di T230
  if :OLD.HMASSENZA = :NEW.HMASSENZA and 
     :OLD.VALORGIOR = :NEW.VALORGIOR and
     :OLD.ABBATTE_STRIND = :NEW.ABBATTE_STRIND then
    return;
  end if;
     
  if :NEW.DECORRENZA_FINE = to_date('31/12/3999','dd/mm/yyyy') then
    update T265_CAUASSENZE set
      HMASSENZA = :NEW.HMASSENZA,
      VALORGIOR = :NEW.VALORGIOR,
      ABBATTE_STRIND = :NEW.ABBATTE_STRIND
    where ID = :new.ID;
  end if;  
exception
  when others then null;  
end T230_AFTERUPDINS;
/
