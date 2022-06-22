create or replace trigger T235_AFTERUPDINS
  after insert or update
  on T235_CAUPRESENZE_PARSTO
  for each row
begin
  --mantiene allineati i dati sulla T265 con l'ultima decorrenza di T230
  if nvl(:OLD.CAUSCOMP_DEBITOGG,'valore_nullo') = nvl(:NEW.CAUSCOMP_DEBITOGG,'valore_nullo') and
     1 = 1
  then
    return;
  end if;

  if :NEW.DECORRENZA_FINE = to_date('31/12/3999','dd/mm/yyyy') then
    null;
    update T275_CAUPRESENZE set
      CAUSCOMP_DEBITOGG = :NEW.CAUSCOMP_DEBITOGG
      /*,parametro2 = :NEW.parametro2*/
    where ID = :new.ID;
  end if;
exception
  when others then null;
end T235_AFTERUPDINS;
/
